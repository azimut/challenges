BEGIN {
    split("3,5,-9,1,3,-2,3,4,7,2,-9,6,3,1,-5,4", arr, ",")
    print kadane(arr)
    print brute(arr)
}

function max(    x,y) { return x>y ? x : y; }
function kadane(arr,    maxEndingHere, maxSoFar) {
    for (i = 1; i <= length(arr); i++) {
        maxEndingHere = max(maxEndingHere + arr[i], arr[i])
        maxSoFar = max(maxEndingHere, maxSoFar)
    }
    return maxSoFar
}
function brute(arr,    sum, maxSum){
    for (i = 1; i <= length(arr); i++) {
        sum = 0
        for (j = i; j <= length(arr); j++) {
            sum += arr[j]
            maxSum = max(maxSum, sum)
        }
    }
    return maxSum
}
