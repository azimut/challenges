function solve(numbers)
   local largests = {0,0,0}
   for idx, val in ipairs(numbers) do
      for i = #largests, 1, -1 do
         if val > largests[i] then
            for j = 1, i, 1 do
               largests[j] = largests[j+1]
            end
            largests[i] = val
            break
         end
      end
   end
   return largests
end

local result = solve({141, 1, 17, -7, -17, -27, 18, 541, 8, 7, 7})
print(string.format("{%d,%d,%d}", result[1], result[2], result[3]))
