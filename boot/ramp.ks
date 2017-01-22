print "RAMP boot".

copypath("0:/ramp", "").
cd("/ramp").

// KEO: 2863334.06
// parking: body:atm:height + (body:radius / 4)
runpath("launch.ks", 72000).
runpath("circ.ks", obt:apoapsis).
runpath("node.ks").

deletepath("/boot").
deletepath("/ramp").

copypath("0:/node.ks").

print "RAMP done".
