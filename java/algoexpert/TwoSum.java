import java.util.*;

// 01. Two Number Sum.mp4

class TwoSum
{
    private static final int[] arr = {3,5,-4,8,11,1,-1,6};
    private static final int targetSum = 10;

    // O(n^2)
    private static String linearSearch(int[] arr, int targetSum) {
        for (int i = 0; i < arr.length-2; i++) {
            for (int j = i+1; j < arr.length-1; j++) {
                if (arr[i] + arr[j] == targetSum) {
                    return String.format("Found `%d` and `%d` sum to `%d`", arr[i], arr[j], targetSum);
                }
            }
        }
        return String.format("No 2 numbers sum to `%d`", targetSum);
    }

    // O(n)
    private static String setSearch(int[] arr, int targetSum) {
        Set<Integer> s = new HashSet<Integer>();
        for (int i = 0; i < arr.length-1; i++) {
            int target = 10 - arr[i];
            if (s.contains(target)) {
                return String.format("Found `%d` and `%d` sum to `%d`", arr[i], target, targetSum);
            }
            else {
                s.add(arr[i]);
            }
        }
        return String.format("No 2 numbers sum to `%d`", targetSum);
    }

    // O(n log n)
    private static String sortedSearch(int[] arr, int targetSum) {
        int left = 0;
        int right = arr.length-1;
        Arrays.sort(arr);
        while (true) {
            int currentSum = arr[left] + arr[right];
            if (currentSum == targetSum) {
                return String.format("Found `%d` and `%d` sum to `%d`", arr[left], arr[right], targetSum);
            }
            if (currentSum > targetSum) {
                right--;
            }
            if (currentSum < targetSum) {
                left++;
            }
            if (left >= right) {
                break;
            }
        }
        return String.format("No 2 numbers sum to `%d`", targetSum);
    }

    public static void main(String[] args)
    {
        System.out.println(arr[0]);
        System.out.println("Linear: " + linearSearch(arr, targetSum));
        System.out.println("Set: "    + setSearch(arr, targetSum));
        System.out.println(Arrays.toString(arr));
        System.out.println("Sorted: " + sortedSearch(arr, targetSum));
        System.out.println(Arrays.toString(arr));
    }
}
