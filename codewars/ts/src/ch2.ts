import { assert } from 'chai';

// https://www.codewars.com/kata/5672a98bdbdd995fad00000f/train/typescript

export function rps(p1: string, p2: string): string {
  if (p1 === p2) return 'Draw!';
  if (
    (p1 === 'rock' && p2 === 'paper') ||
    (p1 === 'paper' && p2 === 'scissors') ||
    (p1 === 'scissors' && p2 === 'rock')
  ) {
    return 'Player 2 won!';
  }
  return 'Player 1 won!';
}

describe('Beginner - Lost Without a Map', () => {
  const getMsg = (n: number): string => `Player ${n} won!`;

  it('player 1 win', () => {
    assert.strictEqual(rps('rock', 'scissors'), getMsg(1));
    assert.strictEqual(rps('scissors', 'paper'), getMsg(1));
    assert.strictEqual(rps('paper', 'rock'), getMsg(1));
  });

  it('player 2 win', () => {
    assert.strictEqual(rps('scissors', 'rock'), getMsg(2));
    assert.strictEqual(rps('paper', 'scissors'), getMsg(2));
    assert.strictEqual(rps('rock', 'paper'), getMsg(2));
  });

  it('draw', () => {
    assert.strictEqual(rps('rock', 'rock'), 'Draw!');
    assert.strictEqual(rps('scissors', 'scissors'), 'Draw!');
    assert.strictEqual(rps('paper', 'paper'), 'Draw!');
  });
});
