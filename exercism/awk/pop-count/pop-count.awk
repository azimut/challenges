{
    while ($1) {
        result = result and($1,1)
        $1 = rshift($1,1)
    }
    print gsub("1", "", result)
}
