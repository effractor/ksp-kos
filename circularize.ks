print "Waiting apoapsis".

lock throttle to 0.
wait 1.

if eta:apoapsis > 360 set warp to 6.
wait until eta:apoapsis < 120.

if eta:apoapsis > 90 set warp to 4.
wait until eta:apoapsis < 30.
set warp to 0.

lock steering to heading(90, 0). // look at east (90), zero degrees above the horizon

wait eta:apoapsis - 0.1. // wait to reach apoapsis
lock throttle to 1. // full power

set oldecc to orbit:eccentricity.
until (oldecc < orbit:eccentricity) { // exists when the eccentricity stop dropping
    set oldecc to orbit:eccentricity.
    
    set power to 1.
    if (orbit:eccentricity < 0.1) {
        // lower the power when eccentricity < 0.1
        set power to max(0.02, orbit:eccentricity * 10).
    }
    
    // radius is altitude plus planet radius
    set radius to altitude + orbit:body:radius.
    
    // gravitational force
    set gforce to constant:g * mass * orbit:body:mass / radius ^ 2.
    
    // centripetal force
    set cforce to mass * ship:velocity:orbit:mag ^ 2 / radius.
    
    // set total force
    set totalforce to gforce - cforce.
    
    set thrust to power * maxthrust.
    
    // check if the thrust is enough to keep the v. speed at ~0m/s
    if (thrust ^ 2 - totalforce ^ 2 < 0) {
        print "The vessel hasn't enough thrust to reach a circular orbit.".
        break.
    }
    
    // the angle above the horizon is the angle 
    set angle to arctan(totalforce / sqrt(thrust ^ 2 - totalforce ^ 2)).
    
    // adjust new values for throttle and steering
    lock throttle to power.
    lock steering to heading(90, angle).
    
    // print stats
    clearscreen.
    print "Attraction:  " + gforce.
    print "Centripetal: " + cforce.
    
    // wait one tenth of a second
    wait 0.1.
}

// shut down engines
lock throttle to 0.
set ship:control:pilotmainthrottle to 0.
print "Orbit reached, eccentricity: " + orbit:eccentricity.
