package main

import "testing"

// go test -bench=. 01.two_number_sum.go 01.two_number_sum_test.go

func BenchmarkLinearSearch(b *testing.B) {
	input := []int{3, 5, -4, 8, 11, 1, -1, 6}
	for i := 0; i < b.N; i++ {
		LinearSearch(input, 10)
	}
}

func BenchmarkLookupTable(b *testing.B) {
	input := []int{3, 5, -4, 8, 11, 1, -1, 6}
	for i := 0; i < b.N; i++ {
		LookupTable(input, 10)
	}
}

func BenchmarkSortedSearch(b *testing.B) {
	input := []int{3, 5, -4, 8, 11, 1, -1, 6}
	for i := 0; i < b.N; i++ {
		SortedSearch(input, 10)
	}
}
