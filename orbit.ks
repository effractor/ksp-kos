clearscreen.

parameter apo.
parameter peri.
parameter turnAlt.

lock throttle to 1.0.

sas off.

print "Counting down:".
from {local countdown is 5.} until countdown = 0 step {set countdown to countdown - 1.} do {
    print "..." + countdown.
    wait 1.
}

// Launch
print "Launch!".

set stg to 1.

// Stagin sequence
when maxthrust = 0 and stg = 1 then {
    stage.
    preserve.
}

set steer to heading(90, 90). // 90 to east and 90 up (straight up)

lock steering to steer.

until ship:apoapsis > apo {
    print "Apoapsis:" + round(ship:apoapsis, 0) at (0, 16).
    print "Periapsis:" + round(ship:periapsis, 0) at (0, 17).

    if ship:altitude >= 3000 and ship:altitude < 5000 {
        set steer to heading(90, 80).
        print "Pitching to 80 degrees" at (0, 15).
    }

    if ship:altitude >= 5000 and ship:altitude < 10000 {
        set steer to heading(90, 70).
        print "Pitching to 70 degrees" at (0, 15).
    }

    if ship:altitude >= 10000 and ship:altitude < 15000 {
        set steer to heading(90, 60).
        print "Pitching to 60 degrees" at (0, 15).
    }

    if ship:altitude >= 15000 and ship:altitude < 25000 {
        set steer to heading(90, 45).
        print "Pitching to 45 degrees" at (0, 15).
    }

    if ship:altitude >= 25000 and ship:altitude < 30000 {
        set steer to heading(90, 30).
        print "Pitching to 30 degrees" at (0, 15).
    }

    if ship:altitude >= 35000 and ship:altitude < 40000 {
        set steer to heading(90, 20).
        print "Pitching to 20 degrees" at (0, 15).
    }

    if ship:altitude >= 40000 {
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


until ship:altitude >= turnAlt {
    wait 0.5.
}

set steer to heading(90, -5).
lock throttle to 1.0.
bays on.
clearscreen.

until ship:periapsis > peri {
    if ship:altitude < turnAlt + 1000 {
        set steer to heading(90, 10).
    }
    if ship:altitude >= turnAlt + 2000 {
        set steer to heading(90, 0).
    }
    print "Apoapsis:" + round(ship:apoapsis, 0) at (0, 16).
    print "Periapsis:" + round(ship:periapsis, 0) at (0, 17).
}

print "On stable orbit".

lock throttle to 0.0.

set ship:control:pilotmainthrottle to 0.0.
