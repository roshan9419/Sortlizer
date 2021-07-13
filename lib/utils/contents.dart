import 'package:sorting_visualization/datamodels/algorithmType.dart';

class DataContent {
  Map<AlgorithmType, String> algorithmsMap = {
    AlgorithmType.BUBBLE_SORT: "Bubble Sort",
    AlgorithmType.INSERTION_SORT: "Insertion Sort",
    AlgorithmType.SELECTION_SORT: "Selection Sort",
    AlgorithmType.MERGE_SORT: "Merge Sort",
    AlgorithmType.QUICK_SORT: "Quick Sort",
    AlgorithmType.CYCLE_SORT: "Cycle Sort",
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
      "QuickSort is a Divide and Conquer algorithm. It picks an element as pivot and partitions the given array around the picked pivot.",
      AlgorithmType.CYCLE_SORT:
      "Cycle sort is an in-place sorting Algorithm, unstable sorting algorithm, a comparison sort that is theoretically optimal in terms of the total number of writes to the original array.",
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
      AlgorithmType.CYCLE_SORT: ["O(n²)", "O(n²)", "O(n²)"],
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
      case AlgorithmType.INSERTION_SORT:
        return insertionSortCode();
      case AlgorithmType.SELECTION_SORT:
        return selectionSortCode();
      case AlgorithmType.MERGE_SORT:
        return mergeSortCode();
      case AlgorithmType.QUICK_SORT:
        return quickSortCode();
      case AlgorithmType.BOGO_SORT:
        return bogoSortCode();
      case AlgorithmType.CYCLE_SORT:
        return cycleSortCode();
      default:
        return "";
    }
  }

  String bubbleSortCode() {
    return """
#include <bits/stdc++.h>
using namespace std;

void bubbleSort(int arr[], int n) {
  for (int i = 0; i < n-1; i++)
    for (int j = 0; j < n-i-1; j++)
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

  String insertionSortCode() {
    return """
#include<bits/stdc++.h>
using namespace std;

void insertionSort(int arr[], int n) {
    for(int i = 0; i < n; ++i) {
    	int temp = arr[i];
    	int j = i;
    	while(j > 0 && temp < arr[j-1]) {
    		arr[j] = arr[j-1];
    		j--;	
		  }
		  arr[j] = temp;
	  }
}

void print(int arr[], int n) {
  for (int i = 0; i < n; i++)
    cout << arr[i] << " ";
}

int main() {
    int arr[] = {34, 8, 64, 51, 32, 21};
    int n = sizeof(arr) / sizeof(arr[0]);

    cout << "Before Sorting: ";
    print(arr, n);
    
    insertionSort(arr, n);
    
    cout << "\\nAfter Sorting: ";
    print(arr, n);
	  
	  return 0;
}
    """;
  }

  String selectionSortCode() {
    return """
#include<bits/stdc++.h>
using namespace std;

void selectionSort(int arr[], int n) {
  for (int i = 0; i < n; i++) {
    int minE = arr[i];
    for (int j = i + 1; j < n; j++) {
      minE = min(arr[j], minE);
    }
    swap(arr[i], minE);
  }
}

void print(int arr[], int n) {
  for (int i=0; i<n; i++)
    cout << arr[i] << " ";
}

int main() {
  int arr[] = {23, 54, 12, 90, 85, 50, 28, 45};
  int n = sizeof(arr) / sizeof(arr[0]);
  
  cout << "Before Sorting: ";
  print(arr, n);
  
  selectionSort(arr, n);
  
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

void merge(int arr[], int L[], int R[], int nl, int nr) {
	int i=0, j=0, k=0;

	while(i < nl && j < nr) {
		if(L[i] <= R[j]) arr[k++] = L[i++];
		else arr[k++] = R[j++];
	}

	while(i<nl) arr[k++] = L[i++];
	while(j<nr) arr[k++] = R[j++];
}

void mergeSort(int arr[], int n) {
	if(n == 1) return;
	int mid = n/2;
	int L[mid], R[n-mid];
	
	for(int i=0; i <= mid; i++) L[i] = arr[i];
	for(int i=mid; i < n; i++) R[i-mid] = arr[i];
	mergeSort(L, mid);
	mergeSort(R, n-mid);
	merge(arr, L, R, mid, n-mid);
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

  String quickSortCode() {
    return """
#include<bits/stdc++.h>
using namespace std;

int partition(int a[], int start, int end) {
	int pivot = a[end];
	int pIndex = start;
	for(int i=start; i<end; i++) {
		if(a[i]<=pivot) {
			swap(a[i], a[pIndex]);
			pIndex++;
		}
	}
	swap(a[pIndex], a[end]);
	return pIndex;
}

void quickSort(int arr[], int start, int end) {
	if(start < end) {
		int pIndex = partition(arr, start, end);
		QuickSort(arr, start, pIndex-1);
		QuickSort(arr, pIndex+1, end);
	}
}

void print(int a[], int n) {
	for(int i=0; i<n; i++)
	  cout << a[i] << " ";
}

int main() {
	int a[10] = {2, 10, 9, 3, 5, 8, 6, 7, 1, 4};
	int n = sizeof(arr) / sizeof(arr[0]);
	
	cout << "Before Sorting: ";
	print(arr, n);
	
	quickSort(arr, 0, n);
	
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

void shuffleArray(int arr[]) {
  for (int i=0; i<n; i++)
    swap(arr[i], arr[rand() % n]);
}

bool isArraySorted(int arr[], int n) {
  for (int i=0; i<n-1; i++)
    if (arr[i] > arr[i+1])
      return false;
  
  return true;
}

void print(int arr[], int n) {
  for (int i=0; i<n; i++)
    cout << arr[i] << " ";
}

int main() {
  
  int arr[] = {10, 50, 80, 30, 20, 40, 60};
  int n = sizeof(arr) / sizeof(arr[0]);
    
  cout << "Before Sorting: ";
  print(arr, n);
  
  while (!isArraySorted(arr, n)) {
    shuffleArray(arr);
  }
  
  cout << "\\nAfter Sorting: ";
  print(arr, n);
  
  return 0;
}

    """;
  }

  String cycleSortCode() {
    return """
#include<bits/stdc++.h>
using namespace std;

int cycleSort(int arr[], int n) {
  int writes = 0;
  for (int cs = 0; cs < n - 1; cs++) {
    int item = arr[cs];
    int pos = cs;
    
    for (int i = cs + 1; i < n; i++) {
      if (arr[i] < item) pos++;
    }
    
    if (pos == cs) continue;
    
    while (item == arr[pos])
      pos++;
     
    if (pos != cs) {
      swap(item, arr[pos]);
      writes++;
    } 
    
    while (pos != cs) {
      pos = cs;
      for (int i = cs + 1; i < n; i++) {
        if (arr[i] < item) pos++;
      }
      
      while (item == arr[pos]) pos++;
      
      if (pos != cs) {
        swap(item, arr[pos]);
        writes++;
      }
    }
  }
  return writes;
}

void print(int arr[], int n) {
  for (int i=0; i<n; i++)
    cout << arr[i] << " ";
}

int main() {
  int arr[] = {23, 59, 21, 8, 75, 80};
  int n = sizeof(arr) / sizeof(arr[0]);
  
  cout << "Before Sorting: ";
  print(arr, n);
  
  int totalWrites = cycleSort(arr, n);
  
  cout << "\\nAfter Sorting: ";
  print(arr, n);
  
  cout << "\\nTotal Writes: " << totalWrites;
  
  return 0;
}
    """;
  }
}
