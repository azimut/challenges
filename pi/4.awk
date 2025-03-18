#!/usr/bin/mawk -f
BEGIN {
    printf "Enter number of random samples to use: "
    getline iterations < "-"
    while (i++ < iterations) {
        x = rand(); y = rand()
        if (sqrt(x*x + y*y) < 1)
            circle++
    }
    printf "%.10g\n", (4*circle)/iterations
}
