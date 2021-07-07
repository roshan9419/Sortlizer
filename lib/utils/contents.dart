import 'package:sorting_visualization/datamodels/algorithmType.dart';
import 'package:charcode/ascii.dart';
import 'package:charcode/html_entity.dart';

class DataContent {
  Map<AlgorithmType, String> algorithmsMap = {
    AlgorithmType.BUBBLE_SORT: "Bubble Sort",
    AlgorithmType.INSERTION_SORT: "Insertion Sort",
    AlgorithmType.SELECTION_SORT: "Selection Sort",
    AlgorithmType.MERGE_SORT: "Merge Sort",
    AlgorithmType.QUICK_SORT: "Quick Sort",
    AlgorithmType.BOGO_SORT: "Bogo Sort",
  };

  String getAlgorithmTitle(AlgorithmType type) {
    return algorithmsMap[type];
  }

  AlgorithmType getAlgorithmType(String algo) {
    var idx = getAlgorithms().indexOf(algo);
    var entryList = algorithmsMap.entries.toList();
    return entryList[idx].key;
  }

  List<String> getAlgorithms() {
    return algorithmsMap.values.toList();
  }

  String getDescription(AlgorithmType type) {
    var algoDesc = {
      AlgorithmType.BUBBLE_SORT:
          "Bubble Sort is the simplest sorting algorithm that works by repeated swapping the adjacent elements if they are in wrong order.",
      AlgorithmType.INSERTION_SORT:
          "Insertion sort is a simple sorting algorithm that works similar to the way you sort playing cards in your hands. The array is virtually split into a sorted and an unsorted part. Values from the unsorted part are picked and placed at the correct position in the sorted part.",
      AlgorithmType.SELECTION_SORT:
          "The selection sort algorithm sorts an array by repeatedly finding the minimum element (considering ascending order) from unsorted part and putting it at the beginning.",
      AlgorithmType.MERGE_SORT:
          "Merge Sort is a Divide and Conquer algorithm. It divides the input array into two halves, calls itself for the two halves, and then merges the two sorted halves. The merge() function is used for merging two halves. The merge(arr, l, m, r) is a key process that assumes that arr[l..m] and arr[m+1..r] are sorted and merges the two sorted sub-arrays into one.",
      AlgorithmType.QUICK_SORT:
          " QuickSort is a Divide and Conquer algorithm. It picks an element as pivot and partitions the given array around the picked pivot.",
      AlgorithmType.BOGO_SORT:
          "BogoSort also known as permutation sort, stupid sort, slow sort, shotgun sort or monkey sort is a particularly ineffective algorithm based on generate and test paradigm. The algorithm successively generates permutations of its input until it finds one that is sorted."
    };

    return algoDesc.containsKey(type) ? algoDesc[type] : "N.A";
  }

  List<String> getTimeComplexities(AlgorithmType type) {
    // [Worst, Avg, Best]
    var complexities = {
      AlgorithmType.BUBBLE_SORT: ["O(n²)", "O(n²)", "O(n)"],
      AlgorithmType.INSERTION_SORT: ["O(n²)", "O(n²)", "O(n)"],
      AlgorithmType.SELECTION_SORT: ["O(n²)", "O(n²)", "O(n²)"],
      AlgorithmType.MERGE_SORT: ["O(nlogn)", "O(nlogn)", "O(nlogn)"],
      AlgorithmType.QUICK_SORT: ["O(n²)", "O(nlgon)", "O(nlogn)"],
      AlgorithmType.BOGO_SORT: ["O(∞)", "O(n*n!)", "O(n)"],
    };
    return complexities.containsKey(type)
        ? complexities[type]
        : ["N.A", "N.A", "N.A"];
  }

  String getAlgorithmCode(AlgorithmType type) {
    switch (type) {
      case AlgorithmType.BUBBLE_SORT:
        return bubbleSortCode();
      case AlgorithmType.MERGE_SORT:
        return mergeSortCode();
      case AlgorithmType.BOGO_SORT:
        return bogoSortCode();
      default:
        return "";
    }
  }

  String bubbleSortCode() {
    return """
#include <bits/stdc++.h>
using namespace std;

void swap(int *xp, int *yp)
{
  int temp = *xp;
  *xp = *yp;
  *yp = temp;
}
// A function to implement bubble sort
void bubbleSort(int arr[], int n)
{
  int i, j;
  for (i = 0; i < n-1; i++)	
  
  // Last i elements are already in place
  for (j = 0; j < n-i-1; j++)
    if (arr[j] > arr[j+1])
  swap(&arr[j], &arr[j+1]);
}

/* Function to print an array */
void printArray(int arr[], int size)
{
  int i;
  for (i = 0; i < size; i++)
    cout << arr[i] << " ";
  cout << endl;
}

// Driver code
int main()
{
  int arr[] = {64, 34, 25, 12, 22, 11, 90};
  int n = sizeof(arr)/sizeof(arr[0]);
  bubbleSort(arr, n);
  cout<<"Sorted array: \\n";
  printArray(arr, n);
  return 0;
}
      """;
  }

  String mergeSortCode() {
    return """
// C++ program for Merge Sort
#include <iostream>
using namespace std;

// Merges two subarrays of array[].
// First subarray is arr[begin..mid]
// Second subarray is arr[mid+1..end]
void merge(int array[], int const left, int const mid, int const right)
{
    auto const subArrayOne = mid - left + 1;
    auto const subArrayTwo = right - mid;

    // Create temp arrays
    auto *leftArray = new int[subArrayOne],
         *rightArray = new int[subArrayTwo];

    // Copy data to temp arrays leftArray[] and rightArray[]
    for (auto i = 0; i < subArrayOne; i++)
        leftArray[i] = array[left + i];
    for (auto j = 0; j < subArrayTwo; j++)
        rightArray[j] = array[mid + 1 + j];

    auto indexOfSubArrayOne = 0, // Initial index of first sub-array
        indexOfSubArrayTwo = 0; // Initial index of second sub-array
    int indexOfMergedArray = left; // Initial index of merged array

    // Merge the temp arrays back into array[left..right]
    while (indexOfSubArrayOne < subArrayOne && indexOfSubArrayTwo < subArrayTwo) {
        if (leftArray[indexOfSubArrayOne] <= rightArray[indexOfSubArrayTwo]) {
            array[indexOfMergedArray] = leftArray[indexOfSubArrayOne];
            indexOfSubArrayOne++;
        }
        else {
            array[indexOfMergedArray] = rightArray[indexOfSubArrayTwo];
            indexOfSubArrayTwo++;
        }
        indexOfMergedArray++;
    }
    // Copy the remaining elements of
    // left[], if there are any
    while (indexOfSubArrayOne < subArrayOne) {
        array[indexOfMergedArray] = leftArray[indexOfSubArrayOne];
        indexOfSubArrayOne++;
        indexOfMergedArray++;
    }
    // Copy the remaining elements of
    // left[], if there are any
    while (indexOfSubArrayTwo < subArrayTwo) {
        array[indexOfMergedArray] = rightArray[indexOfSubArrayTwo];
        indexOfSubArrayTwo++;
        indexOfMergedArray++;
    }
}

// begin is for left index and end is
// right index of the sub-array
// of arr to be sorted */
void mergeSort(int array[], int const begin, int const end)
{
    if (begin >= end)
        return; // Returns recursively

    auto mid = begin + (end - begin) / 2;
    mergeSort(array, begin, mid);
    mergeSort(array, mid + 1, end);
    merge(array, begin, mid, end);
}

// UTILITY FUNCTIONS
// Function to print an array
void printArray(int A[], int size)
{
    for (auto i = 0; i < size; i++)
        cout << A[i] << " ";
}

// Driver code
int main()
{
    int arr[] = { 12, 11, 13, 5, 6, 7 };
    auto arr_size = sizeof(arr) / sizeof(arr[0]);

    cout << "Given array is \\n";
    printArray(arr, arr_size);

    mergeSort(arr, 0, arr_size - 1);

    cout << "\\nSorted array is \\n";
    printArray(arr, arr_size);
    return 0;
}
    """;
  }

  String bogoSortCode() {
    return """
#include <bits/stdc++.h>
using namespace std;

int main() {
  int n;
  cout << "Size of the array: ";
  cin >> n;
  
  int arr[n];
  for (int i = 0; i < n; i++)
    cin >> arr[i];
    
  while (!isArraySorted(arr, n)) {
    shuffleArray(arr);
  }
  
  //Print Array
  return 0;
}

    """;
  }
}
