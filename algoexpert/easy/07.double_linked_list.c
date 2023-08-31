#include <stdio.h>

typedef struct DList {
  int value;
  struct DList *next, *prev;
} DList;

DList *search(int value, DList *head) {
  DList *cursor = head;
  while (cursor->next) {
    if (cursor->value == value)
      return cursor;
    cursor = cursor->next;
  }
  return NULL;
}

void delete (DList *node, DList **head, DList **tail) {
  if (node == *head) {
    *head->next->prev = NULL;
    *head = head.next;
  } else if (node == *tail) {
    *tail->prev->next = NULL;
    *tail = *tail->prev;
  } else {
    node->next->prev = node->prev;
    node->prev->next = node->next;
    node->prev = node->next = NULL;
  }
}

void deleteAll(int value, DList *head, DList *tail) {
  DList *next, *found = search(value, head);
  while (found) {
    next = found->next;
    delete (found, head, tail);
    found = search(value, next);
  }
}

void insertBefore(DList *node, DList *before, DList **head, DList **tail) {
  if (node == before)
    return;
  delete (node, head, tail);
  node->next = before;
  if (before->prev) {
    before->prev->next = node;
    node->prev = before->prev;
  } else {
    node->prev = NULL;
  }
  before->prev = node;
}

void insertAfter(DList *node, DList *after, DList *head, DList *tail) {
  if (node == after)
    return;
  delete (node, head, tail);
  node->prev = after;
  if (after->next) { // If NOT the tail
    after->next->prev = node;
    node->next = after->next;
  } else {
    node->next = NULL;
  }
  after->next = node;
}

void setHead(DList *node, DList **head, DList **tail) {
  if (*head == NULL && *tail == NULL) {
    *head = *tail = node;
  }
  insertBefore(node, head, head, tail);
}

void setTail(DList *node, DList *head, DList *tail) {
  if (head == NULL && tail == NULL)
    head = tail = node;
  insertAfter(node, tail, head, tail);
}

void printDList(DList *head) {
  DList *cursor = head;
  while (cursor) {
    printf("%d\n", cursor->value);
    cursor = cursor->next;
  }
}

int main() {
  DList *head, *tail;
  head = tail = NULL;
  printf("HEAD: %p\n", (void *)head);
  printf("TAIL: %p\n", (void *)tail);
  setHead(&(DList){1, NULL, NULL}, &head, &tail);
  setHead(&(DList){2, NULL, NULL}, &head, &tail);
  printf("HEAD: %p\n", (void *)head);
  printf("TAIL: %p\n", (void *)tail);
  printDList(head);
  return 0;
}
