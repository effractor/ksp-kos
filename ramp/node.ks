global nodeNd is nextnode.

print "Executing circ node".

global nodeStageFuelInit is 0.

sas off.
lock steering to lookdirup(nodeNd:deltav, ship:facing:topvector).

global nodeAccel is ship:availablethrust / ship:mass.
global nodeFacing is lookdirup(nodeNd:deltav, ship:facing:topvector).
global nodeDob is (nodeNd:deltav:mag / nodeAccel).

wait until vdot(facing:forevector, nodeFacing:forevector) >= 0.995 or nodeNd:eta <= nodeDob / 2.

global nodeHang is (nodeNd:eta - nodeDob/2) - 3.
if nodeHang > 0 {
  runpath("warp.ks", nodeHang).
  wait 3.
}

set warp to 0.

global nodeDone  is false.
global nodeDv0   is nodeNd:deltav.
global nodeDvMin is nodeDv0:mag.

until nodeDone
{
    set nodeAccel to ship:availablethrust / ship:mass.

    if(nodeNd:deltav:mag < nodeDvMin) {
        set nodeDvMin to nodeNd:deltav:mag.
    }

    if nodeAccel > 0 {
      set ship:control:pilotmainthrottle to min(nodeDvMin/nodeAccel, 1.0).
      set nodeDone to (vdot(nodeDv0, nodeNd:deltav) < 0) or
                      (nodeNd:deltav:mag > nodeDvMin + 0.1) or
                      (nodeNd:deltav:mag <= 0.2).
    } else {
        local now is time:seconds.
        if nodeStageFuelInit = 0 or stage:liquidfuel < nodeStageFuelInit {
          stage.
          wait until stage:ready.
          set nodeStageFuelInit to stage:liquidfuel.
        }
    }
}
lock throttle to 0.
set ship:control:pilotmainthrottle to 0.
unlock steering.

if nodeNd:deltav:mag > 0.1 {
  rcs on.
  local t0 is time.
  until nodeNd:deltav:mag < 0.1 or (time - t0):seconds > 15 {
    local sense is ship:facing.
    local dirV is V(
      vdot(nodeNd:deltav, sense:starvector),
      vdot(nodeNd:deltav, sense:upvector),
      vdot(nodeNd:deltav, sense:vector)
    ).

    set ship:control:translation to dirV:normalized.
  }
  set ship:control:translation to 0.
  rcs off.
}

remove nodeNd.
sas on.

print "Circulaze finished".
