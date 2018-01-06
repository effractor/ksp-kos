copypath("0:/launch.ks", "").
runpath("launch.ks", 75000).
deletepath("launch.ks").

copypath("0:/circularize.ks", "").
runpath("circularize.ks").
deletepath("circularize.ks").

deletepath("boot").
