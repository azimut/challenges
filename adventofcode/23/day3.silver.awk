BEGIN { FS = "" }

{
    start = 0
    for (col = 1; col <= NF; col++) {
        schematic[NR][col] = $col
        if ($col ~ /[0-9]/) {
            start = start ? start : col
        } else {
            start = 0
        }
    }
    # gsub(/[^0-9]/, " ")
    # for (i = 1; i <= split($0, arr); i++)
    #     sum += arr[i]
}

END {
    for (i = 1; i <= NR; i++) {
        for (j = 1; j <= NF; j++) {
            printf schematic[i][j]
        }
        print ""
    }
}

# 4361
# END {
#     for (row in schematic) { # row
#         start = 0
#         current = ""
#         for (col in schematic[row]) { # col
#             if (schematic[row][col] ~ /[0-9]/) {
#                 start = start ? start : col
#                 current = current schematic[row][col]
#             } else {
#                 if (start) {
#                     if (isAroundOperator)
#                         sum += int(current)
#                 }
#                 current = ""
#                 start = 0
#                 isAroundOperator = 0
#             }
#         }
#     }
#     print sum
# }
