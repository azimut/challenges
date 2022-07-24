import { expect } from 'chai';

// https://www.codewars.com/kata/5287e858c6b5a9678200083c/train/typescript
// https://en.wikipedia.org/wiki/Narcissistic_number
//
// A Narcissistic Number is a positive number which is the sum of its own digits, each raised to the power of the number
// of digits in a given base. In this Kata, we will restrict ourselves to decimal (base 10).

// The Challenge:

// Your code must return true or false depending upon whether the given number is a
// Narcissistic number in base 10.

// only valid positive non-zero integers will be passed

export function narcissistic(value: number): boolean {
  const power = Math.floor(Math.log10(value)) + 1;
  let result = 0;
  let tmp = value;
  while (tmp > 0) {
    result += Math.pow(tmp % 10, power);
    tmp = Math.floor(tmp / 10);
  }
  return result === value;
}

describe('Basic tests', () => {
  it('Basic test should work', () => {
    expect(narcissistic(7)).to.equal(true, '7 is narcissistic');
    // 1^3 + 5^3 + 3^3 = 1 + 125 + 27 = 153
    expect(narcissistic(153)).to.equal(true, '153 is narcissistic');
    expect(narcissistic(1634)).to.equal(true, '1634 is narcissistic');
  });
});
