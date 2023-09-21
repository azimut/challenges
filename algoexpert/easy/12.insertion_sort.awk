BEGIN {
    split("8,5,2,9,5,6,3", arr, ",")
    insertion_sort(arr)
    for (idx in arr)
        printf latch++?",%s":"%s", arr[idx]
}

function insertion_sort(arr,    u,s,tmp) {
    for (u = 2; u <= length(arr); u++)
        for (s = u-1; s > 0; s--) {
            if (arr[u] < arr[s]) {
                tmp = arr[u]
                arr[u] = arr[s]
                arr[s] = tmp
                u = s
            } else {
                break
            }
        }
}
