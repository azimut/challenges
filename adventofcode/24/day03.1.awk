BEGIN { FPAT = "mul\\([0-9]{1,3},[0-9]{1,3}\\)"}
{
    for (i = 1; i <= NF; i++) {
        gsub("[^0-9,]","",$i)
        split($i,numbers,",")
        total += numbers[1]*numbers[2]
    }
}
END { print total }
