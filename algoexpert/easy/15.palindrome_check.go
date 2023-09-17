package main

import (
	"fmt"
)

// TODO: isPalindromeRev Join

func isPalindromeRev(s string) bool {
	var revs string
	for i := len(s) - 1; i >= 0; i-- {
		revs += string(s[i])
	}
	return revs == s
}

func isPalindromeRecAEHelpTail(s string, i int) bool {
	j := len(s) - 1 - i
	if i >= j {
		return true
	}
	if s[i] != s[j] {
		return false
	}
	return isPalindromeRecAEHelpTail(s, i+1)
}
func isPalindromeRecAEHelp(s string, i int) bool {
	j := len(s) - 1 - i
	if i >= j {
		return true
	}
	return s[i] == s[j] && isPalindromeRecAEHelp(s, i+1)
}
func isPalindromeRecAE(s string) bool {
	return isPalindromeRecAEHelp(s, 0)
}

func isPalindromeRec(s string) bool {
	size := len(s)
	if size == 1 {
		return true
	}
	return s[0] == s[size-1] && isPalindromeRec(s[1:size-1])
}

func isPalindromeIter(s string) bool {
	left := 0
	right := len(s) - 1
	for left <= right {
		if s[left] == s[right] {
			left++
			right--
		} else {
			return false
		}
	}
	return true
}

func main() {
	f := isPalindromeRecAE
	word := "amanaplanacanalpanama"
	if f(word) {
		fmt.Printf("`%s` is a palindrome\n", word)
	} else {
		fmt.Printf("`%s` is NOT a palindrome\n", word)
	}
	word = "abecedario"
	if f(word) {
		fmt.Printf("`%s` is a palindrome\n", word)
	} else {
		fmt.Printf("`%s` is NOT a palindrome\n", word)
	}
}
