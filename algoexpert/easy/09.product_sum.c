#include <stdio.h>

typedef struct List {
  int value;
  struct List *head;
  struct List *tail;
} List;

// FIXME: outputs 23, when it should output 71
int sum_product_aux(struct List *list, int depth) {
  int sum = 0;

  if (list->head)
    sum += sum_product_aux(list->head, depth + 1);
  else
    sum += list->value;

  if (list->tail)
    sum += sum_product_aux(list->tail, depth);

  return sum * depth;
}

int sum_product(struct List *list) { return sum_product_aux(list, 1); }

void foo(struct List list) {}

int main(void) {
  struct List list = {
      1,
      NULL,
      &(List){
          2,
          NULL,
          &(List){3, NULL,
                  &(List){0,
                          &(List){1, NULL,
                                  &(List){
                                      3,
                                      NULL,
                                      NULL,
                                  }},
                          &(List){
                              3,
                              NULL,
                              NULL,
                          }}},
      },
  };
  printf("sum product is: %d\n", sum_product(&list));
  return 0;
}
