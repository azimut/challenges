import { expect } from 'chai';

// Your goal in this kata is to implement a difference function, which subtracts one list from another and returns the result.
// It should remove all values from list a, which are present in list b keeping their order.
// If a value is present in b, all of its occurrences must be removed from the other:

export function arrayDiff(a: number[], b: number[]): number[] {
  return a.filter((v) => !b.includes(v));
}

describe('Basic tests', () => {
  it('Basic test should work', () => {
    expect(arrayDiff([], [4, 5])).to.eql([], 'a was [], b was [4,5]');
    expect(arrayDiff([3, 4], [3])).to.eql([4], 'a was [3, 4], b was [3]');
    expect(arrayDiff([1, 8, 2], [])).to.eql([1, 8, 2], 'a was [1, 8, 2], b was []');
    expect(arrayDiff([1, 2, 3], [1, 2])).to.eql([3], 'a was [1, 2, 3], b was [1, 2]');
    expect(arrayDiff([1, 2, 2, 2, 3], [2])).to.eql([1, 3], 'a was [1, 2, 2, 2, 3], b was [2]');
    expect(arrayDiff([1, 2], [1])).to.eql([2], 'a was [1, 2], b was [1]');
  });
});
