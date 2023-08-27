function solve(lst) {
  return lst.sort((a,b) => a-b).slice(-3);
}

console.log(solve([141, 1, 17, -7, -17, -27, 18, 541, 8, 7, 7]))
