import { assert } from 'chai';

// https://www.codewars.com/kata/5ce399e0047a45001c853c2b/train/typescript
//
// Let us consider this example (array written in general format):
// ls = [0, 1, 3, 6, 10]
//
// Its following parts:
// ls = [0, 1, 3, 6, 10]
// ls = [1, 3, 6, 10]
// ls = [3, 6, 10]
// ls = [6, 10]
// ls = [10]
// ls = []

// The corresponding sums are (put together in a list):
//  [20, 20, 19, 16, 10, 0]

// The function parts_sums (or its variants in other languages) will take as parameter a list ls and return a list of
// the sums of its parts as defined above.

// Notes: Take a look at performance: some lists have thousands of elements.

export function partsSums(ls: number[]): number[] {
  const ret: number[] = [0];
  ls.reduceRight((prev, curr) => {
    ret.push(prev + curr);
    return prev + curr;
  }, 0);
  return ret.reverse();
}

describe('partsSums', function () {
  function dotest(ls: number[], expect: number[]) {
    const actual = partsSums(ls);
    assert.deepEqual(actual, expect);
  }

  it('Basic tests', function () {
    dotest([], [0]);
    dotest([0, 1, 3, 6, 10], [20, 20, 19, 16, 10, 0]);
    dotest([1, 2, 3, 4, 5, 6], [21, 20, 18, 15, 11, 6, 0]);
    dotest(
      [744125, 935, 407, 454, 430, 90, 144, 6710213, 889, 810, 2579358],
      [10037855, 9293730, 9292795, 9292388, 9291934, 9291504, 9291414, 9291270, 2581057, 2580168, 2579358, 0],
    );
  });
});
