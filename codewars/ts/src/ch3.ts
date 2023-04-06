import { assert } from 'chai';

// https://www.codewars.com/kata/546e2562b03326a88e000020/train/typescript
//
// Welcome. In this kata, you are asked to square every digit of a number and concatenate them.
// For example, if we run 9119 through the function, 811181 will come out, because 9^2 is 81 and 1^2 is 1.
//
// Note: The function accepts an integer and returns an integer

export class Kata {
  static squareDigits(num: number): number {
    let result = '';
    while (num > 0) {
      const tmp = num % 10;
      result = String(tmp * tmp) + result;
      num = Math.floor(num / 10);
    }
    return Number(result === '' ? 0 : result);
  }
}

describe('squareDigits', function () {
  it('should pass a sample test', function () {
    assert.strictEqual(Kata.squareDigits(9119), 811181);
    assert.strictEqual(Kata.squareDigits(0), 0);
  });
});
