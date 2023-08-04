#!/bin/bash

# https://www.hackerrank.com/challenges/fractal-trees-all/problem

# Initialize GRID
rows=63
cols=100
for ((idx = 0; idx < rows * cols; idx++)); do
	grid[idx]='_'
done

# Process GRID
iterations=5 # read -r iterations
positions=(-1 $(((cols - 1) / 2)))
length=16
for _ in $(seq 1 ${iterations}); do
	tmp_positions=()
	for ((p = 0; p < ${#positions[@]}; p += 2)); do
		x=${positions[p]}
		y=${positions[p + 1]}
		# Vertical Branch
		for i in $(seq 1 ${length}); do
			((x++))
			grid[cols * x + y]='1' # width * row + col
		done
		tmp_x=${x}
		tmp_y=${y}
		# Left Branch
		for _ in $(seq 1 ${length}); do
			((x++, y--))
			grid[cols * x + y]='1' # width * row + col
		done
		tmp_positions[${#tmp_positions[@]}]=${x}
		tmp_positions[${#tmp_positions[@]}]=${y}
		# Right Branch
		x=${tmp_x}
		y=${tmp_y}
		for _ in $(seq 1 ${length}); do
			((x++, y++))
			grid[cols * x + y]='1' # width * row + col
		done
		tmp_positions[${#tmp_positions[@]}]=${x}
		tmp_positions[${#tmp_positions[@]}]=${y}
	done
	positions=("${tmp_positions[@]}")
	length=$((length / 2))
done

# Print GRID
for ((row = rows; row > 0; row--)); do
	printf '%s' "${grid[@]:cols*row:cols}"
	echo
done
