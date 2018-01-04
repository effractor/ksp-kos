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

wait until altitude > 70000.
print "Stage 1 done".
stage.

wait until eta:apoapsis < 10.
stage.
lock throttle to 1.
print "Burn.".

wait until periapsis > 75000.
lock throttle to 0.
print "On stable orbit.".

wait until eta:periapsis < 10.
lock throttle to 0.3.
print "Set apoapsis.".

wait until apoapsis > 150000.
lock throttle to 0.
print "Done.".

wait until eta:apoapsis < 10.
lock throttle to 0.3.
print "Set periapsis.".

wait until periapsis > 148000.
lock throttle to 0.
print "Done.".

set ship:control:pilotmainthrottle to 0.
print "End program.".
