BEGIN {
    split("8,5,2,9,5,6,3", arr, ",")
    bubble_sort(arr)
    for (idx in arr)
        printf latch++?",%s":"%s", arr[idx]
}

function bubble_sort(arr,    tmp, ceil, done) {
    ceil = length(arr)-1
    while (!done) {
        done = 1
        for (i = 1; i <= ceil; i++) {
            if (arr[i] > arr[i+1]) {
                tmp = arr[i]
                arr[i] = arr[i+1]
                arr[i+1] = tmp
                done = 0
            }
        }
        ceil--
    }
}
