print "RAMP boot".

copypath("0:/ramp", "").
cd("/ramp").

// KEO: 2863334.06
// parking: body:atm:height + (body:radius / 4)
runpath("launch.ks", 75000).
runpath("circ.ks", obt:apoapsis).
runpath("node.ks").

cd("/").

deletepath("/ramp").
deletepath("/boot").

copypath("0:/node.ks", "").

print "RAMP done".
