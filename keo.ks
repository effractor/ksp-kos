lock throttle to 0.
lock steering to prograde.

wait 10.

lock throttle to 1.

wait until apoapsis > 2863333.52.
lock throttle to 0.

copypath("0:/circularize.ks", "").
runpath("circularize.ks").
deletepath("circularize.ks").

deletepath("keo.ks").

set ship:control:pilotmainthrottle to 0.
