clearscreen.

lock throttle to 1.0.

print "Counting down:".
from {local countdown is 3.} until countdown = 0 step {set countdown to countdown - 1.} do {
    print "..." + countdown.
    wait 1.
}

// Launch
print "Launch!".

set stg to 1.

// Stagin sequence
when maxthrust = 0 and stg = 1 then {
    print "Staging".
    stage.
    preserve.
}

set steer to heading(90, 90). // 90 to east and 90 up (straight up)

lock steering to steer.

until ship:apoapsis > 75000 {
    print "Apoapsis:" + round(ship:apoapsis, 0) at (0, 16).
    print "Periapsis:" + round(ship:periapsis, 0) at (0, 17).

    if ship:velocity:surface:mag >= 100 and ship:velocity:surface:mag < 200 {
        set steer to heading(90, 80).
        print "Pitching to 80 degrees" at (0, 15).
    }

    if ship:velocity:surface:mag >= 300 and ship:velocity:surface:mag < 400 {
        set steer to heading(90, 70).
        print "Pitching to 70 degrees" at (0, 15).
    }

    if ship:velocity:surface:mag >= 500 and ship:velocity:surface:mag < 600 {
        set steer to heading(90, 45).
        print "Pitching to 45 degrees" at (0, 15).
    }

    if ship:velocity:surface:mag >= 900 and ship:velocity:surface:mag < 1000 {
        set steer to heading(90, 10).
        print "Pitching to 10 degrees" at (0, 15).
    }
}

print "75km apoapsis reached, cutting throttle".

// Do not stage 
set stg to 0.
lock throttle to 0.0.

clearscreen.
print "Preparing for circularing burn".

set steer to heading(90, -10).

wait until eta:apoapsis < 15.

set throttle to 0.5.

clearscreen.

until ship:periapsis > 70000 {
    print "Apoapsis:" + round(ship:apoapsis, 0) at (0, 16).
    print "Periapsis:" + round(ship:periapsis, 0) at (0, 17).
}

print "On stable orbit".

lock throttle to 0.0.

set ship:control:pilotmainthrottle to 0.0.
