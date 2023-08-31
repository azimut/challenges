#!/usr/bin/env python

class DList:

    def __init__(self, value):
        self.value = value
        self.prev = None
        self.next = None

    def search(self, value):
        cursor = self
        while cursor:
            if cursor.value == value:
                return cursor
            else:
                cursor = cursor.next

    def remove(self, node):
        node.prev.next = node.next
        node.next.prev = node.prev
        node.prev = node.next = None

    def removeAll(self, value):
        cursor = self
        while cursor:
            if cursor.value == value:
                cursor.prev.next = cursor.next
                cursor.next.prev = cursor.prev
                cursor.prev = cursor.next = None
            else:
                cursor = cursor.next


if __name__ == '__main__':
    main()
