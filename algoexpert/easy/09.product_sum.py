#!/usr/bin/env python


def product_sum(lst, depth=1):
    sum = 0

    for el in lst:
        if type(el) is list:  # isinstance(el, type([]))
            sum += product_sum(el, depth+1)
        else:
            sum += el

    return sum * depth


if __name__ == '__main__':
    print(product_sum([1, 2, 3, [1, 3], 3]))
