#include <limits.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
  int value;
  struct Node *left;
  struct Node *right;
} Node;

static Node *bst =
    &(Node){10,
            &(Node){5, &(Node){2, &(Node){1, NULL, NULL}, NULL},
                    &(Node){5, NULL, NULL}},
            &(Node){15, &(Node){13, NULL, &(Node){14, NULL, NULL}},
                    &(Node){22, NULL, NULL}}};

// O(log n) avt time | O(n) worst time (aka a tree with only 1 branch)
int find_closest(Node *bst, int value) {
  int closest = INT_MAX; // aka +infinity
  int node_closeness, current_closeness, node_value;
  while (bst) {
    node_value = bst->value;
    node_closeness = abs(node_value - value);
    current_closeness = abs(closest - value);
    if (node_closeness < current_closeness) {
      closest = node_value;
    }
    if (node_value == value)
      break;
    if (node_value > value)
      bst = bst->left;
    if (node_value < value)
      bst = bst->right;
  }
  return closest == INT_MAX ? -1 : closest;
}

int find_closest_recursive_helper(Node *bst, int value, int current) {
  if (!bst)
    return current;
  if (abs(value - current) > abs(value - bst->value))
    current = bst->value;

  if (value < bst->value)
    return find_closest_recursive_helper(bst->left, value, current);
  if (value > bst->value)
    return find_closest_recursive_helper(bst->right, value, current);

  return current;
}

// O(log n) avg time | O(log n) avg space
int find_closest_recursive(Node *bst, int value) {
  return find_closest_recursive_helper(bst, value, INT_MAX);
}

int main(void) {
  int targetValue;
  printf("bst->left->value: %d\n", bst->left->value);
  targetValue = 12; // Expected output 13
  printf("Closest to %d in BST is %d\n", targetValue,
         find_closest(bst, targetValue));
  targetValue = 15; // Expected output 15
  printf("Closest to %d in BST is %d\n", targetValue,
         find_closest(bst, targetValue));
  printf("\n");
  targetValue = 12; // Expected output 13
  printf("Closest to %d in BST is %d\n", targetValue,
         find_closest_recursive(bst, targetValue));
  targetValue = 15; // Expected output 15
  printf("Closest to %d in BST is %d\n", targetValue,
         find_closest_recursive(bst, targetValue));
  return 0;
}
