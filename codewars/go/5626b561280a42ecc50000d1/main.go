package main

// https://www.codewars.com/kata/5626b561280a42ecc50000d1/train/go

import (
	"fmt"
)

func reverse(xs []uint64) (rxs []uint64) {
	for i := len(xs) - 1; i >= 0; i-- {
		rxs = append(rxs, xs[i])
	}
	return
}

func digits(n uint64) (result []uint64) {
	for n >= 10 {
		result = append(result, n%10)
		n = n / 10
	}
	return reverse(append(result, n))
}

func is_eureka(n uint64) bool {
	var sum uint64
	pieces := digits(n)
	for i, piece := range pieces {
		sum += pow(piece, uint64(i)+1)
	}
	return sum == n
}

func SumDigPow(a, b uint64) []uint64 {
	result := make([]uint64, 0)
	for i := a; i <= b; i++ {
		if is_eureka(i) {
			result = append(result, i)
		}
	}
	return result
}

func pow(base, power uint64) uint64 {
	result := base
	for i := uint64(1); i < power; i++ {
		result = result * base
	}
	return result
}

func main() {
	fmt.Println(digits(123))
	fmt.Println(is_eureka(89))
	fmt.Println(is_eureka(101))
	fmt.Println(SumDigPow(1, 100))
	fmt.Println(SumDigPow(12157692622039623066, 12157692622039625687))
	fmt.Println(is_eureka(12157692622039623539))
	// var sum uint64
	// fmt.Println(digits(12157692622039623539))
	// for index, value := range digits(12157692622039623539) {
	// 	sum += pow(value, uint64(index)+1)
	// }
	// fmt.Println(sum, sum == 12157692622039623539)
	// 12157692622039623506
	// 12157692622039623539
	//  12157 69262 20396 23539
	// [12157 69262 20396 23539]
}
