import { assert } from 'chai';

// Return the number (count) of vowels in the given string.
// We will consider a, e, i, o, u as vowels for this Kata (but not y).
// The input string will only consist of lower case letters and/or spaces.

export class Kata {
  static getCount(str: string): number {
    return str.split('').filter((letter) => 'aeiou'.includes(letter)).length;
  }
}

describe('getCount', function () {
  it('should pass a sample test', function () {
    assert.strictEqual(Kata.getCount('abracadabra'), 5);
  });
});
