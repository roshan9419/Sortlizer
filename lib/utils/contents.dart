import 'package:sorting_visualization/datamodels/algorithmType.dart';

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

void bubbleSort(int arr[], int n) {
  for (int i = 0; i < n-1; i++) // n times
    for (int j = 0; j < n-i-1; j++) // n times
      if (arr[j] > arr[j+1])
        swap(arr[j], arr[j+1]);
}

void print(int arr[], int n) {
  for (int i = 0; i < n; i++)
    cout << arr[i] << " ";
}

int main() {
  int arr[] = {10, 20, 10, 90, 30, 80, 70};
  int n = sizeof(arr) / sizeof(arr[0]);
  
  cout << "Before Sorting: ";
  print(arr, n);
  
  bubbleSort(arr, n);
  
  cout << "\\nAfter Sorting: ";
  print(arr, n);
  
  return 0;
}
      """;
  }

  String mergeSortCode() {
    return """
#include<bits/stdc++.h>
using namespace std;

void merge(int a[], int L[], int R[], int nl, int nr) {
	int i=0, j=0, k=0;

	while(i < nl && j < nr) {
		if(L[i] <= R[j]) a[k++] = L[i++];
		else a[k++] = R[j++];
	}

	while(i<nl) a[k++] = L[i++];
	while(j<nr) a[k++] = R[j++];
}

void mergeSort(int a[], int n) {
	if(n == 1) return;
	int mid = n/2;
	int L[mid], R[n-mid];
	
	for(int i=0; i <= mid; i++) L[i] = a[i];
	for(int i=mid; i < n; i++) R[i-mid] = a[i];
	mergeSort(L, mid);
	mergeSort(R, n-mid);
	merge(a, L, R, mid, n-mid);
}

void print(int arr[], int n) {
	for(int i=0; i<n; i++)
		cout << arr[i] << " ";
}

int main() {
	int arr[10] = {12, 42, 32, 4, 2, 55, 32, 56, 23};
	int n = sizeof(arr) / sizeof(arr[0]);
	
	cout << "Before Sorting: ";
	print(arr, n);
	
	mergeSort(arr, n);
	
	cout << "\\nAfter Sorting: ";
	print(arr, n);
	
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
