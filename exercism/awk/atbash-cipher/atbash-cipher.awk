{ $0 = tolower($0); gsub(/[^0-9a-z]/, "") }

direction == "decode" {
    for (i = 1; i <= length; i++)
        printf "%s", convert(substr($0, i, 1))
}

direction == "encode" {
    for (i = 1; i <= length; i++)
        printf((i%5 || i == length) ? "%s" : "%s ", convert(substr($0, i, 1)))
}

function convert(char,    abc) {
    abc = "abcdefghijklmnopqrstuvwxyz"
    return match(char, /[a-z]/) ? substr(abc, 27 - index(abc, char), 1) : char;
}
