function product_sum(lst, sum, depth)
   for _, val in pairs(lst) do
      if type(val) == "table" then
         sum = sum + product_sum(val, 0, depth+1)
      else
         sum = sum + val
      end
   end
   return sum * depth
end

print(product_sum({1, 2, 3, {1, 3}, 3}, 0, 1))
