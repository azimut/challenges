package main

import (
	"fmt"
	"sort"
)

// O(n^3) time
func LinearSearch(numbers []int, target int) (result [][]int) {
	for i := 0; i < len(numbers)-2; i++ {
		for j := i + 1; j < len(numbers)-1; j++ {
			for k := j + 1; k < len(numbers); k++ {
				if numbers[i]+numbers[j]+numbers[k] == target {
					result = append(result, []int{numbers[i], numbers[j], numbers[k]})
				}
			}
		}
	}
	return
}

// O(n^2)
func SortedSearch(numbers []int, target int) (result [][]int) {
	var left, right, current int
	sort.Ints(numbers)
	for key, number := range numbers {
		left, right = key+1, len(numbers)-1
		for left < right {
			current = number + numbers[left] + numbers[right]
			if current == target {
				result = append(result, []int{number, numbers[left], numbers[right]})
				left += 1
				right -= 1
			}
			if current < target {
				left += 1
			}
			if current > target {
				right -= 1
			}
		}
	}
	return
}

func main() {
	input := []int{12, 3, 1, 2, -6, 5, -8, 6}
	target := 0
	fmt.Printf("%+v\n", LinearSearch(input, target)) // output for debug
	fmt.Printf("%+v\n", SortedSearch(input, target)) // output for debug
}
