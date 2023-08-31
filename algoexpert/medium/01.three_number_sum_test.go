package main

import "testing"

// go test -bench=. 01.three_number_sum.go 01.three_number_sum_test.go

func BenchmarkLinearSearch(b *testing.B) {
	input := []int{12, 3, 1, 2, -6, 5, -8, 6}
	target := 0
	for i := 0; i < b.N; i++ {
		LinearSearch(input, target)
	}
}

func BenchmarkSortedSearch(b *testing.B) {
	input := []int{12, 3, 1, 2, -6, 5, -8, 6}
	target := 0
	for i := 0; i < b.N; i++ {
		SortedSearch(input, target)
	}
}
