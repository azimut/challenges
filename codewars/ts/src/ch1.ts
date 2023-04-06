import { assert } from 'chai';

// https://www.codewars.com/kata/55685cd7ad70877c23000102/train/typescript

// In this simple assignment you are given a number and have to make it negative.
// But maybe the number is already negative?

// Notes

//     The number can be negative already, in which case no change is required.
//     Zero (0) is not checked for any specific sign. Negative zeros make no mathematical sense.

export const makeNegative = (num: number): number => {
  return num <= 0 ? num : num * -1;
};

describe('makeNegative', function () {
  it('Sample tests', function () {
    assert.equal(makeNegative(1), -1);
    assert.equal(makeNegative(-5), -5);
    assert.equal(makeNegative(0), 0);
    assert.equal(makeNegative(42), -42);
  });
});
