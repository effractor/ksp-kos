print "Orbiter I: launch!".

copypath("0:/orbit.ks", "").

runpath("orbit.ks", 75000, 70000, 72000).

deletepath("/boot").
deletepath("/orbit.ks").
copypath("0:/node.ks", "").

clearscreen.
print "Orbiter I: done".
