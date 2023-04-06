import { assert } from 'chai';

// https://www.codewars.com/kata/54da5a58ea159efa38000836/train/typescript
//
// Given an array of integers, find the one that appears an odd number of times.
// There will always be only one integer that appears an odd number of times.

export const findOdd = (xs: number[]): number => {
  const counter: number[] = [];
  xs.forEach((v) => (counter[v] ? (counter[v] += 1) : (counter[v] = 1)));
  return counter.findIndex((v) => v % 2 > 0);
};

describe('Example tests', function () {
  doTest([20, 1, -1, 2, -2, 3, 3, 5, 5, 1, 2, 4, 20, 4, -1, -2, 5], 5);
  doTest([1, 1, 2, -2, 5, 2, 4, 4, -1, -2, 5], -1);
  doTest([20, 1, 1, 2, 2, 3, 3, 5, 5, 4, 20, 4, 5], 5);
  doTest([10], 10);
  doTest([1, 1, 1, 1, 1, 1, 10, 1, 1, 1, 1], 10);
  doTest([5, 4, 3, 2, 1, 5, 4, 3, 2, 10, 10], 1);
  doTest([7], 7);
  doTest([0], 0);
  doTest([1, 1, 2], 2);
  doTest([0, 1, 0, 1, 0], 0);
  doTest([1, 2, 2, 3, 3, 3, 4, 3, 3, 3, 2, 2, 1], 4);
});

function doTest(a: number[], n: number) {
  it(`xs = ${JSON.stringify(a)} ; n = ${n}`, () => {
    assert.strictEqual(findOdd(a), n);
  });
}
