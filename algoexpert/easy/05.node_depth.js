#!/usr/bin/env node

class Node {
  constructor(value, left=null, right=null) {
    this.value = value;
    this.left = left;
    this.right = right;
    this.depth = 0;
  }
}

const bt =
      new Node(1,
               new Node(22,
                        new Node(4,
                                 new Node(8),
                                 new Node(9)),
                        new Node(5)),
               new Node(3,
                        new Node(6),
                        new Node(7)));

function calculate_depth_helper(bt, depth) {
  if (!bt) return depth;
  let current = 0;
  if(bt.left) current += calculate_depth_helper(bt.left, depth + 1);
  if(bt.right) current += calculate_depth_helper(bt.right, depth + 1);
  return depth + current;
}
function calculate_depth_recursive(bt) {
  return calculate_depth_helper(bt, 0);
}

function calculate_depth_iterative(bt) {
  let sum = 0;
  let depth = 0;
  let stack = [];
  stack.push(bt);
  while (stack.length) {
    let node = stack.pop();
    sum += node.depth;
    if (node.left) {
      node.left.depth = depth;
      stack.push(node.left);
    }
    if (node.right) {
      node.right.depth = depth;
      stack.push(node.right);
    }
    depth++;
  }
  return sum;
}

console.log(calculate_depth_recursive(bt));
console.log(calculate_depth_iterative(bt));
