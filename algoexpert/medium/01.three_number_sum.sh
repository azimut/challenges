#!/bin/bash

input=(12 3 1 2 -6 5 -8 6)
target=0

for ((i = 0; i < ${#input[@]} - 2; i++)); do
	for ((j = i + 1; j < ${#input[@]} - 1; j++)); do
		for ((k = j + 1; k < ${#input[@]}; k++)); do
			if ((input[i] + input[j] + input[k] == target)); then
				printf "found: %d+%d+%d=%d\n" \
					"${input[i]}" \
					"${input[j]}" \
					"${input[k]}" \
					"${target}"
			fi
		done
	done
done
