import { assert } from 'chai';

// https://www.codewars.com/kata/55f2b110f61eb01779000053/train/typescript

// Given two integers a and b, which can be positive or negative,
//  find the sum of all the integers between and including
//  them and return it. If the two numbers are equal return a or b.

// Note: a and b are not ordered!

export function getSum(a: number, b: number): number {
  const distance = Math.abs(a - b) + 1;
  return a === b ? a : (distance / 2) * (a + b);
}

describe('getSum', function () {
  it('Sample Tests', function () {
    assert.strictEqual(getSum(1, 1), 1);
    assert.strictEqual(getSum(0, -1), -1);
    assert.strictEqual(getSum(1, 0), 1); //  (1 + 0 = 1)
    assert.strictEqual(getSum(1, 2), 3); //  (1 + 2 = 3)
    assert.strictEqual(getSum(0, 1), 1); //  (0 + 1 = 1)
    assert.strictEqual(getSum(1, 1), 1); //  (1 since both are same)
    assert.strictEqual(getSum(-1, 0), -1); //  (-1 + 0 = -1)
    assert.strictEqual(getSum(-1, 2), 2); //  (-1 + 0 + 1 + 2 = 2)
  });
});
