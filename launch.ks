// staging trigger
when stage:liquidfuel < 0.1 then {
    print "Staging.".
    stage.
    preserve.
}

lock throttle to 1.
lock steering to up + R(0, 0, 180).

stage.
print "Launch!".

wait until altitude > 10000.
lock steering to up + R(0,0,180) + R(0,-60,0).
print "Beginning gravity turn.".

wait until apoapsis > 80000.
lock throttle to 0.
lock steering to prograde.
print "Waiting for circularization burn.".

wait until eta:apoapsis < 15.
lock throttle to 1.
print "Burn.".

wait until periapsis > 75000.
lock throttle to 0.
