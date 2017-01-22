parameter alt.

print "Circulaze at alt: " + alt.

local mu is body:mu.
local br is body:radius.
local vom is velocity:orbit:mag.
local r is br + altitude.
local ra is br + apoapsis.
local v1 is sqrt(vom^2 + 2*mu*(1/ra - 1/r)).
local sma1 is (periapsis + 2*br + apoapsis)/2.
local r2 is br + apoapsis.
local sma2 is (alt + 2*br + apoapsis)/2.
local v2 is sqrt(vom^2 + (mu * (2/r2 - 2/r + 1/sma1 - 1/sma2))).
local deltav is v2 - v1.
local nd is node(time:seconds + eta:apoapsis, 0, 0, deltav).

add nd.

print "Circulaze node set".
