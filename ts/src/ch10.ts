import { assert } from 'chai';

// Count the number of Duplicates

// Write a function that will return the count of distinct case-insensitive alphabetic characters and numeric digits
// that occur more than once in the input string. The input string can be assumed to contain only alphabets (both
// uppercase and lowercase) and numeric digits.

export function duplicateCount(text: string): number {
  return [...new Set([...text.toLowerCase()].filter((c, _, a) => a.filter((f) => f === c).length > 1))].length;
}

describe('example', function () {
  it('test', function () {
    assert.equal(duplicateCount(''), 0);
    assert.equal(duplicateCount('abcde'), 0);
    assert.equal(duplicateCount('aabbcde'), 2);
    assert.equal(duplicateCount('aabBcde'), 2, 'should ignore case');
    assert.equal(duplicateCount('Indivisibility'), 1);
    assert.equal(duplicateCount('Indivisibilities'), 2, 'characters may not be adjacent');
    assert.equal(duplicateCount('indivisibility'), 1);
    assert.equal(duplicateCount('aA11'), 2);
    assert.equal(duplicateCount('ABBA'), 2);
  });
});
