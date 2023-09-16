BEGIN {
    split("0,1,21,33,45,45,61,71,72,73", numbers, ",")
    target = 33
    print target, (binarySearch(target, 1, length(numbers)) ? "is" : "is NOT"), "on the array"
    print target, (binarySearchAE(target, 1, length(numbers)) ? "is" : "is NOT"), "on the array"

}

function binarySearch(target,    left, right, middle) {
    if (left > right) return 0
    middle = int((left+right)/2)
    if (numbers[middle] > target)
        return binarySearch(target, left, middle-1)
    if (numbers[middle] < target)
        return binarySearch(target, middle+1, right)
    return middle
}

function binarySearchAE(target,    left, right, middle) {
    while (left <= right) {
        middle = int((left+right)/2)
        if (numbers[middle] > target)
            right = middle - 1
        if (numbers[middle] < target)
            left = middle + 1
        if (numbers[middle] == target)
            return middle
    }
    return 0
}
