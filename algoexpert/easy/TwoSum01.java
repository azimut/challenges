import java.util.*;

// 01. Two Number Sum.mp4
//
// 100_000 random array // target sum = 1_000
//
// Linear: [1940665280, -1940664280]
// System execution time: 13251
//
// Set: [230282379, -230282369]
// System execution time: 20
//
// Sorted: [-1940664280, 1940665280]
// System execution time: 33

class TwoSum01
{
    // no number is repeated in ARR
    private static final int[] arr = {3,5,-4,8,11,1,-1,6};
    private static final int targetSum = 10;

    // O(n^2)
    private static String linearSearch(int[] arr, int targetSum) {
        for (int i = 0; i < arr.length-1; i++) {
            for (int j = i+1; j < arr.length; j++) {
                if (arr[i] + arr[j] == targetSum) {
                    return String.format("[%d, %d]", arr[i], arr[j]);
                }
            }
        }
        return String.format("No 2 numbers sum to `%d`", targetSum);
    }
    // O(n) - Hash Table, we lookup for "complement" sum
    private static String setSearch(int[] arr, int targetSum) {
        Set<Integer> s = new HashSet<Integer>();
        for (int i = 0; i < arr.length-1; i++) {
            int target = 10 - arr[i];
            if (s.contains(target)) {
                return String.format("[%d, %d]", arr[i], target);
            }
            else {
                s.add(arr[i]);
            }
        }
        return String.format("No 2 numbers sum to `%d`", targetSum);
    }

    // O(n log n) - sorting - better than 2 for loops
    private static String sortedSearch(int[] arr, int targetSum) {
        int left = 0;
        int right = arr.length-1;
        Arrays.sort(arr);
        while (true) {
            int currentSum = arr[left] + arr[right];
            if (currentSum == targetSum) {
                return String.format("[%d, %d]",
                                     arr[left],
                                     arr[right]);
            }
            if (currentSum > targetSum) right--;
            if (currentSum < targetSum) left++;
            if (left >= right) {
                break;
            }
        }
        return String.format("No 2 numbers sum to `%d`", targetSum);
    }

    public static void main(String[] args)
    {
        System.out.println(Arrays.toString(arr));
        System.out.println("Linear: " + linearSearch(arr, targetSum));
        System.out.println("Set: "    + setSearch(arr, targetSum));
        System.out.println("Sorted: " + sortedSearch(arr, targetSum));
        System.out.println(Arrays.toString(arr));
        Random rd = new Random();
        int[] bar = new int[100000];
        for (int i = 0; i < bar.length; i++) {
            bar[i] = rd.nextInt();
        }
        long startTime;
        long endTime;
        startTime = System.currentTimeMillis();
        System.out.println("Linear: " + linearSearch(bar, 1000));
        endTime = System.currentTimeMillis();
        System.out.println("System execution time: " + (endTime - startTime));

        startTime = System.currentTimeMillis();
        System.out.println("Set: "    + setSearch(bar, 1000));
        endTime = System.currentTimeMillis();
        System.out.println("System execution time: " + (endTime - startTime));

        startTime = System.currentTimeMillis();
        System.out.println("Sorted: " + sortedSearch(bar, 1000));
        endTime = System.currentTimeMillis();
        System.out.println("System execution time: " + (endTime - startTime));
    }
}
