set fuel_mass to 0.

for res in stage:resources {
    if res:name = "LiquidFuel" {
        set fuel_mass to fuel_mass + res:density * res:amount.
    }
}

print "Fuel mass: " + fuel_mass.

set stats to lexicon().

list parts in ps.
for p in ps {
    set stats["Stage " + p:stage] to lexicon("fuel tanks", list(), "engines", list()).
}

list engines in es.
for p in ps {
    for e in es {
       if e = p {
           stats["Stage " + p:stage]["engines"]:add(e).
       }
    }
    for r in p:resources {
        if r:name = "liquidfuel" {
            stats["Stage " + p:stage]["fuel tanks"]:add(p).
        }
    }
}

for k in stats:keys {
    if stats[k]["engines"]:length = 0 and stats[k]["fuel tanks"]:length = 0 {
        stats:remove(k).
    }
}   
print stats.
