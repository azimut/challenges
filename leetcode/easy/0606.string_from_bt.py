#!/usr/bin/env python

# INCOMPLETE

class Tree:
    def __init__(self, val, left=None, right=None):
        self.left = left
        self.right = right
        self.val = val

    def __str__(self):
        if not self.left and self.right:
            left = "()"
        elif self.left:
            left = f"({self.left})"
        else:
            left = ""
        right = f"({self.right})" if self.right else ""
        return f"{self.val}" + left + right


# neetcode solution, uses an array instead of string concatenation
class Solution:
    def tree2str(self, root: Optional[Tree]) -> str:
        res = []
        def preorder(root):
            if not root:
                return
            res.append("(")
            res.append(str(root.val))

            if not root.left and root.right:
                res.append("()")

            preorder(root.left)
            preorder(root.right)
            res.append(")")
        preorder(root)
        return "".join(res)[1:-1]


if __name__ == '__main__':
    bt = Tree(10, Tree(2, Tree(4)), Tree(3))
    print(bt)
