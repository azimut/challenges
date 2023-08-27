package main

import "fmt"

type arr struct {
	value int
	curr  *arr
	next  *arr
}

// FIXME: outputs 23, when it should output 17
func solve(input arr, depth int) int {
	var sum int

	if input.curr != nil {
		sum += solve(*input.curr, depth+1)
	} else {
		sum += input.value
	}

	if input.next != nil {
		sum += solve(*input.next, depth)
	}

	return sum * depth
}

func main() {
	input := arr{1, nil, &arr{2, nil, &arr{3, nil, &arr{
		0,
		&arr{1, nil, &arr{3, nil, nil}},
		&arr{3, nil, nil}}}},
	}
	output := solve(input, 1)
	fmt.Println(output)
}
