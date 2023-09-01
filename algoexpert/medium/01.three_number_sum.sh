#!/bin/bash

set -e

input=(12 3 1 2 -6 5 -8 6)
target=0

echo "--- linear ---"

for ((i = 0; i < ${#input[@]} - 2; i++)); do
	for ((j = i + 1; j < ${#input[@]} - 1; j++)); do
		for ((k = j + 1; k < ${#input[@]}; k++)); do
			if ((input[i] + input[j] + input[k] == target)); then
				printf "[%d,%d,%d]\n" "${input[i]}" "${input[j]}" "${input[k]}"
			fi
		done
	done
done

echo "--- sorted ---"

IFS=$'\n'
sorted=($(sort -n <<<"${input[*]}"))
unset IFS

for ((i = 0; i < ${#sorted[@]} - 2; i++)); do
	left=$((i + 1))
	right=$((${#sorted[@]} - 1))
	while ((left < right)); do
		current=$((sorted[i] + sorted[left] + sorted[right]))
		if ((current == target)); then
			printf "[%d,%d,%d]\n" ${sorted[i]} ${sorted[left]} ${sorted[right]}
			((left++, right--))
		else
			((current < target ? left++ : right--))
		fi
	done
done
