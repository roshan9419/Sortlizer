import 'package:sorting_visualization/datamodels/algorithmType.dart';

class DataContent {

  Map<AlgorithmType, String> algorithmsMap = {
    AlgorithmType.BUBBLE_SORT: "Bubble Sort",
    AlgorithmType.INSERTION_SORT: "Insertion Sort",
    AlgorithmType.SELECTION_SORT: "Selection Sort",
    AlgorithmType.MERGE_SORT: "Merge Sort",
    AlgorithmType.QUICK_SORT: "Quick Sort"
  };

  String getAlgorithmTitle(AlgorithmType type) {
    return algorithmsMap[type];
  }

  List<String> getAlgorithms() {
    return [
      "Bubble Sort",
      "Insertion Sort",
      "Selection Sort",
      "Merge Sort",
      "Quick Sort"
    ];
  }

  String getDescription(AlgorithmType type) {
    switch (type) {
      case AlgorithmType.BUBBLE_SORT:
        return bubbleSortDescription();
        break;
      case AlgorithmType.INSERTION_SORT:
        return bubbleSortDescription();
        break;
      case AlgorithmType.SELECTION_SORT:
        return bubbleSortDescription();
        break;
      case AlgorithmType.MERGE_SORT:
        return bubbleSortDescription();
        break;
      case AlgorithmType.QUICK_SORT:
        return bubbleSortDescription();
        break;
      default:
        return "Algorithm Not Available";
    }
  }

  List<String> getTimeComplexities(AlgorithmType type) {
    switch (type) {
      case AlgorithmType.BUBBLE_SORT:
        return bubbleSortTimeComplexities();
        break;
      case AlgorithmType.INSERTION_SORT:
        return bubbleSortTimeComplexities();
        break;
      case AlgorithmType.SELECTION_SORT:
        return bubbleSortTimeComplexities();
        break;
      case AlgorithmType.MERGE_SORT:
        return bubbleSortTimeComplexities();
        break;
      case AlgorithmType.QUICK_SORT:
        return bubbleSortTimeComplexities();
        break;
      default:
        return ["N.A", "N.A", "N.A"];
    }
  }

  String bubbleSortDescription() {
    return "Bubble Sort is the simplest sorting algorithm that works by repeated swapping the adjacent elements if they are in wrong order.";
  }

  List<String> bubbleSortTimeComplexities() {
    // worst, avg, best
    return ["O(n^2)", "O(n^2)", "O(n)"];
  }

  String bubbleSortCode() {
    return
      """
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
        cout<<"Sorted array: \n";
        printArray(arr, n);
        return 0;
      }
      """;
  }

  String getAlgorithmCode(AlgorithmType type) {
    switch (type) {
      case AlgorithmType.BUBBLE_SORT:
        return bubbleSortCode();
        break;
      case AlgorithmType.INSERTION_SORT:
        return bubbleSortCode();
        break;
      case AlgorithmType.SELECTION_SORT:
        return bubbleSortCode();
        break;
      case AlgorithmType.MERGE_SORT:
        return bubbleSortCode();
        break;
      case AlgorithmType.QUICK_SORT:
        return bubbleSortCode();
        break;
      default:
        return "N.A";
    }
  }
}
