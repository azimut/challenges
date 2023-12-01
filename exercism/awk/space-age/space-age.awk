BEGIN {
    p2y["Mercury"] = 0.2408467
    p2y["Venus"]   = 0.61519726
    p2y["Earth"]   = 1.0
    p2y["Mars"]    = 1.8808158
    p2y["Jupiter"] = 11.862615
    p2y["Saturn"]  = 29.447498
    p2y["Uranus"]  = 84.016846
    p2y["Neptune"] = 164.79132
}
 !($1 in p2y) { print "not a planet"; exit 1 }
              { printf("%.2f", ($2/60/60/24/365.25) / p2y[$1]) }
