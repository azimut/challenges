package main

import (
	"log"
)

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

// https://www.codewars.com/kata/545a4c5a61aa4c6916000755/train/go
func Gimme(array [3]int) int {
	var result int
	b := min(min(array[0], array[1]), array[2])
	t := max(max(array[0], array[1]), array[2])
	for key, value := range array {
		if value != b && value != t {
			result = key
		}
	}
	return result
}

func main() {
	var got, expected int
	got = Gimme([3]int{2, 3, 1})
	expected = 0
	if got != expected {
		log.Panicf("got %d, but expected %d", got, expected)
	}
	got = Gimme([3]int{5, 10, 14})
	expected = 1
	if got != expected {
		log.Panicf("got %d, but expected %d", got, expected)
	}
}
