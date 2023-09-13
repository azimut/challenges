BEGIN {
    for (i = (start ? start : verse); i >= (stop ? stop : verse); i--) {
        if (i) print bottles(i), "of beer on the wall,", bottles(i), "of beer."
        else   print "No more bottles of beer on the wall, no more bottles of beer."
        if (i) print "Take", i == 1 ? "it" : "one", "down and pass it around,", bottles(i-1), "of beer on the wall."
        else   print "Go to the store and buy some more, 99 bottles of beer on the wall."
    }
}
function bottles(    n) { return n ? (n" bottle"(n>1?"s":"")) : "no more bottles" }
