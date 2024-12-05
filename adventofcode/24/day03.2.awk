BEGIN {
    FPAT = "mul\\([0-9]{1,3},[0-9]{1,3}\\)|do\\(\\)|don't\\(\\)"
    enabled = 1
}
{
    for (i = 1; i <= NF; i++) {
        updateState($i)
        if (!enabled) continue
        gsub("[^0-9,]","",$i)
        split($i,numbers,",")
        total += numbers[1]*numbers[2]
    }
}
END { print total }

function updateState(instruction) {
    switch (instruction) {
    case "do()" :
        enabled = 1
        break
    case "don't()":
        enabled = 0
        break
    }
}
