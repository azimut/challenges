import { assert } from 'chai';

// https://www.codewars.com/kata/51b62bf6a9c58071c600001b/train/typescript
// Solution took from: https://www.youtube.com/watch?v=ohBNdSJyLh8

// Create a function taking a positive integer as its parameter and returning a string containing the Roman Numeral
// representation of that integer.

// Modern Roman numerals are written by expressing each digit separately starting with the left most digit and skipping
// any digit with a value of zero.

// Symbol    Value
// I          1
// V          5
// X          10
// L          50
// C          100
// D          500
// M          1,000

// Remember that there can't be more than 3 identical symbols in a row.

// More about roman numerals - http://en.wikipedia.org/wiki/Roman_numerals

export function solution(n: number): string {
  let result = '';
  const decimal = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
  const roman = ['M', 'CM', 'D', 'CD', 'C', 'XC', 'L', 'XL', 'X', 'IX', 'V', 'IV', 'I'];
  roman.map((sym, idx) => {
    const value = decimal[idx];
    const times = Math.floor(n / value);
    if (times > 0) {
      n = n % value;
      result += sym.repeat(times);
    }
  });
  return result;
}

describe('solution', function () {
  it('basic', function () {
    assert.strictEqual(solution(1000), 'M');
    assert.strictEqual(solution(4), 'IV');
    assert.strictEqual(solution(1), 'I');
    assert.strictEqual(solution(1666), 'MDCLXVI');
    assert.strictEqual(solution(1990), 'MCMXC');
    assert.strictEqual(solution(2008), 'MMVIII');
    assert.strictEqual(solution(1444), 'MCDXLIV');
  });
});
