function solve_naive(xs, ys) {
  let current = Infinity;
  let diff = 0;
  let pair = [0,0];
  let iter = 0;
  for(const x of xs)
    for(const y of ys) {
      iter++;
      diff = x - y;
      if (Math.abs(diff) < current) {
        current = Math.abs(diff)
        pair = [x,y];
      }
    }
  console.log(pair, iter);
  return current;
}

function solve(xs, ys) {
  let current = Infinity;
  let pair = [0, 0];
  let diff = 0;
  let iter = 0;
  xs.sort((a,b) => a - b);
  ys.sort((a,b) => a - b);
  for(const x of xs)
    for(const y of ys) {
      iter++;
      diff = x - y;
      if (Math.abs(diff) < current) {
        current = Math.abs(diff);
        pair = [x,y];
      }
      if (x < y) break;
      if (x > y) continue;
      if (x == y) {
        console.log([x,y]);
        return current;
      }
    }
  console.log(pair, iter);
  return current;
}

console.log(solve_naive([-1, 5, 10, 20, 28, 3], [26, 134, 135, 15, 17]));
console.log(solve([-1, 5, 10, 20, 28, 3], [26, 134, 135, 15, 17]));
