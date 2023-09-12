BEGIN {
    if (num % 3 == 0) rain = rain"Pling"
    if (num % 5 == 0) rain = rain"Plang"
    if (num % 7 == 0) rain = rain"Plong"
    printf rain ? rain : num
}
