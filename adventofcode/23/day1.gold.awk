BEGIN { split("one two three four five six seven eight nine", numbers) }
      { for (n in numbers) gsub(numbers[n], "&"n"&") }
match($0,/^[a-z]*([0-9])/,a) { digit = a[1] }
match($0,/([0-9])[a-z]*$/,a) { digit = digit a[1] }
      { sum += int(digit) }
  END { print sum }
