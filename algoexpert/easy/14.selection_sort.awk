BEGIN {
    split("8,5,2,9,5,6,3", arr, ",")
    selection_sort(arr)
    for (idx in arr)
        printf latch++?",%s":"%s", arr[idx]
}

function selection_sort(arr,    min, tmp) {
    for (usort = 1; usort <= length(arr); usort++) {
        min_idx = usort
        for (i = usort+1; i <= length(arr); i++)
            if (arr[i] < arr[min_idx])
                min_idx = i
        tmp = arr[min_idx]
        arr[min_idx] = arr[usort]
        arr[usort] = tmp
    }
}
