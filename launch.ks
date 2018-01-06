parameter apo.

if apo < 72000 {
    set apo to 72000.
}.

lock throttle to 1.
lock steering to up + r(0, 0, 180).

when stage:liquidfuel < 0.1 then {
    stage.
    preserve.
}

stage.
print "Launch!".

wait until altitude > 10000.
lock steering to up + r(0, 0, 180) + r(0, -60, 0).
print "Beginning gravity turn.".

wait until apoapsis > apo.
lock throttle to 0.
print "Waiting for circularization burn.".
lock steering to prograde.
