package main

import "fmt"

func powerset(sets []int) (result [][]int) {
	for i := 0; i < len(sets); i++ {
		for j := i; j < len(sets); j++ {
			result = append(result, sets[i:j+1])
		}
	}
	return append(result, []int{})
}

func main() {
	input := []int{1, 2, 3}
	fmt.Printf("power sets of %v are %v", input, powerset(input))
}
