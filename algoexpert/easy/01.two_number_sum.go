package main

import (
	"fmt"
	"sort"
)

func LinearSearch(numbers []int, target int) string {
	for _, a := range numbers {
		for _, b := range numbers {
			if a+b == target {
				return "Linear: found"
			}
		}
	}
	return "Linear: NOT found"
}

func LookupTable(numbers []int, target int) string {
	var complement int
	cache := make(map[int]bool)
	for _, number := range numbers {
		complement = target - number
		if _, exists := cache[complement]; exists {
			return "Lookup: found"
		}
		cache[number] = true
	}
	return "Lookup: NOT found"
}

func SortedSearch(numbers []int, target int) string {
	sort.Ints(numbers)
	left := 0
	right := len(numbers) - 1
	var diff int
	for {
		diff = numbers[left] + numbers[right]
		if diff > target {
			right -= 1
		}
		if diff < target {
			left += 1
		}
		if diff == target {
			return "Sorted: found"
		}
		if left >= right {
			break
		}
	}
	return "Sorted: NOT found"
}

func main() {
	input := []int{3, 5, -4, 8, 11, 1, -1, 6}
	fmt.Println(LinearSearch(input, 10))
	fmt.Println(LookupTable(input, 10))
	fmt.Println(SortedSearch(input, 10))
}
