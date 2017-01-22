parameter apo.

print "Launch to apo:" + apo.

global launch_tick is 1.
global launch_tSrbSep is 0.
global launch_tStage is time:seconds.
global launch_gt0 is body:atm:height * 0.1.
global launch_gt1 is body:atm:height * 0.8.
global launch_gtScale is 1.

function ascentSteering {
  local gtPct is (ship:altitude - launch_gt0) / (launch_gt1 - launch_gt0).
  local inclin is min(90, max(0, 90 * cos(launch_gtScale * 90 * gtPct))).
  local gtFacing is heading(90, inclin):vector.
  local prodot is vdot(ship:facing:vector, prograde:vector).

  if gtPct <= 0 {
    return heading(0, 90).
  } else {
    return lookdirup(gtFacing, ship:facing:upvector).
  }
}

function ascentThrottle {
  local aoa is vdot(ship:facing:vector, ship:velocity:surface).
  local atmPct is ship:altitude / (body:atm:height+1).
  local spd is ship:velocity:surface:mag.
  local cutoff is 200 + (400 * max(0, atmPct)).

  if spd > cutoff and launch_tSrbSep = 0 {
    return 1 - (1 * (spd - cutoff) / cutoff).
  } else {
    return 1.
  }
}

function ascentStaging {
  local Neng is 0.
  local Nsrb is 0.
  local Nout is 0.

  list engines in engs.
  for eng in engs {
    if eng:ignition {
      set Neng to Neng + 1.
      if not eng:allowshutdown {
        set Nsrb to Nsrb + 1.
      }
      if eng:flameout {
        set Nout to Nout + 1.
      }
    }
  }

  if (Nsrb > 0) and (stage:solidfuel < 10) {
    stage.
    set launch_tSrbSep to time:seconds.
    set launch_tStage to launch_tSrbSep.
  } else if (Nout = Neng) {
    wait until stage:ready.
    stage.
    set launch_tStage to time:seconds.
  }
}

sas off.

if ship:status <> "prelaunch" and stage:solidfuel = 0 {
  set launch_tSrbSep to time:seconds.
}

lock steering to ascentSteering().
lock throttle to ascentThrottle().
set ship:control:pilotmainthrottle to 0.

until ship:obt:apoapsis >= apo {
  ascentStaging().
  wait launch_tick.
}

unlock throttle.
set ship:control:pilotmainthrottle to 0.

sas on.

if stage:resourceslex:haskey("LiquidFuel") and stage:resourceslex["LiquidFuel"]:amount / stage:resourceslex["LiquidFuel"]:capacity < 0.1 {
  stage.
  wait until stage:ready.
}

until ship:availablethrust > 0 {
  stage.
  wait until stage:ready.
}

print "Finishing gravity turn".
