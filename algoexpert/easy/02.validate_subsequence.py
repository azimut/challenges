#!/usr/bin/env python3

# O(n) time | O(1) space
def is_subseq_while(array, sequence):
    arrIdx = 0
    seqIdx = 0
    while arrIdx < len(array) and seqIdx < len(sequence):
        if array[arrIdx] == sequence[seqIdx]:
            seqIdx += 1
        arrIdx += 1
    return seqIdx == len(sequence)


# O(n) time | O(1) space
def is_subseq_for(array, sequence):
    seqIdx = 0
    for value in array:
        if seqIdx == len(sequence):
            break
        if sequence[seqIdx] == value:
            seqIdx += 1
    return seqIdx == len(sequence)


# O(n) time | O(1) space
def is_subseq(arr, subseq):
    last_index = 0
    for i in range(len(subseq)):
        for j in range(last_index, len(arr)):
            if arr[j] == subseq[i]:
                break
            last_index += 1
        else:
            return False
    return True


if __name__ == '__main__':
    seq = [5, 1, 22, 25, 6, -1, 8, 10]
    sub = [1, 6, -1, 10]
    print(is_subseq(seq, sub))
    print(is_subseq_for(seq, sub))
    print(is_subseq_while(seq, sub))
