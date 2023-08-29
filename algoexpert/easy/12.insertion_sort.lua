function solve(numbers)
   for i = 2, #numbers, 1 do
      for j = i - 1, 1, -1 do
         if numbers[j] > numbers[i] then
            numbers[i], numbers[j] = numbers[j], numbers[i]
            i = j
         else
            break
         end
      end
   end
   return numbers
end

local result = solve({8, 5, 2, 9, 5, 6, 3})
for _, val in ipairs(result) do
   print(val)
end
