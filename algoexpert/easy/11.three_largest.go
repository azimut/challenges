package main

import (
	"fmt"
	"sort"
)

func solve(input []int) []int {
	sort.Ints(input)
	return input[len(input)-3:]
}

func main() {
	fmt.Println(solve([]int{141, 1, 17, -7, -17, -27, 18, 541, 8, 7, 7}))
}
