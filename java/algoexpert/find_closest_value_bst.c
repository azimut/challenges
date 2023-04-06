#include <stdio.h>
#include <limits.h>
#include <stdlib.h>

typedef struct Node {
  int value;
  struct Node* left;
  struct Node* right;
} Node;

static Node* bst =
  &(Node){10,
          &(Node){5,
                  &(Node){2,&(Node){1, NULL,NULL},NULL},
                  &(Node){5, NULL, NULL}},
          &(Node){15,
                  &(Node){13,NULL, &(Node){14,NULL,NULL}},
                  &(Node){22,NULL,NULL}}};
// O(log n)
int find_closest(Node* bst, int value) {
  int closest = INT_MAX; // aka +infinity
  int node_closeness, current_closeness, node_value;
  while (bst) {
    node_value = bst->value;
    node_closeness = abs(node_value - value);
    current_closeness = abs(closest - value);
    if (node_closeness < current_closeness) {
      closest = node_value;
    }
    if (node_value == value) break;
    if (node_value > value) bst = bst->left;
    if (node_value < value) bst = bst->right;
  }
  return closest == INT_MAX ? -1 : closest;
}

int main(void)
{
  int targetValue;
  printf("bst->left->value: %d\n", bst->left->value);
  targetValue = 12; // Expected output 13
  printf("Closest to %d in BST is %d\n", targetValue, find_closest(bst, targetValue));
  targetValue = 15; // Expected output 15
  printf("Closest to %d in BST is %d\n", targetValue, find_closest(bst, targetValue));
  return 0;
}
