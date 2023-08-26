const input = [1, 2, 3, [1, 3], 3];

function product_sum(lst, depth) {
  let sum = 0;

  for(const el of lst) {
    if (Array.isArray(el)) {
      sum += product_sum(el, depth+1)
    } else {
      sum += el;
    }
  }

  return sum * depth;
}

console.log("sum product is: " + product_sum(input, 1));
