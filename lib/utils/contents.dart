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
    AlgorithmType.RADIX_SORT: "Radix Sort",
    AlgorithmType.COCKTAIL_SORT: "Cocktail Sort",
    AlgorithmType.ODD_EVEN_SORT: "Odd Even Sort",
    AlgorithmType.HEAP_SORT: "Heap Sort",
    AlgorithmType.SHELL_SORT: "Shell Sort"
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
          "BogoSort also known as permutation sort, stupid sort, slow sort, shotgun sort or monkey sort is a particularly ineffective algorithm based on generate and test paradigm. The algorithm successively generates permutations of its input until it finds one that is sorted.",
      AlgorithmType.RADIX_SORT:
          "Radix sort is a sorting algorithm that sorts the elements by first grouping the individual digits of the same place value. Then, sort the elements according to their increasing/decreasing order.",
      AlgorithmType.COCKTAIL_SORT:
          "Cocktail Sort is a variation of Bubble sort. The Bubble sort algorithm always traverses elements from left and moves the largest element to its correct position in first iteration and second largest in second iteration and so on. Cocktail Sort traverses through a given array in both directions alternatively.",
      AlgorithmType.ODD_EVEN_SORT:
          "This algorithm is divided into two phases- Odd and Even Phase. The algorithm runs until the array elements are sorted and in each iteration two phases occurs- Odd and Even Phases. In the odd phase, we perform a bubble sort on odd indexed elements and in the even phase, we perform a bubble sort on even indexed elements.",
      AlgorithmType.HEAP_SORT:
          "Heap sort is a comparison-based sorting technique based on Binary Heap data structure. It is similar to selection sort where we first find the minimum element and place the minimum element at the beginning. We repeat the same process for the remaining elements.",
      AlgorithmType.SHELL_SORT:
          "The idea of shellSort is to allow exchange of far items. In shellSort, we make the array h-sorted for a large value of h. We keep reducing the value of h until it becomes 1. An array is said to be h-sorted if all sublists of every h’th element is sorted."
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
      AlgorithmType.RADIX_SORT: ["O(n+k)", "O(n+k)", "O(n+k)"],
      AlgorithmType.COCKTAIL_SORT: ["O(n²)", "O(n²)", "O(n)"],
      AlgorithmType.ODD_EVEN_SORT: ["O(n²)", "O(n²)", "O(n)"],
      AlgorithmType.HEAP_SORT: ["O(nlogn)", "O(nlogn)", "O(nlogn)"],
      AlgorithmType.SHELL_SORT: ["O(n²)", "O(nlogn)", "O(nlogn)"],
    };
    return complexities.containsKey(type)
        ? complexities[type]
        : ["N.A", "N.A", "N.A"];
  }

  String getSpaceComplexity(AlgorithmType type) {
    return "O(1)";
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
      case AlgorithmType.RADIX_SORT:
        return radixSortCode();
      case AlgorithmType.COCKTAIL_SORT:
        return cocktailSortCode();
      case AlgorithmType.ODD_EVEN_SORT:
        return oddEvenSortCode();
      case AlgorithmType.HEAP_SORT:
        return heapSortCode();
      case AlgorithmType.SHELL_SORT:
        return shellSortCode();
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

  String radixSortCode() {
    return """
#include<bits/stdc++.h>
using namespace std;

int getMax(int arr[], int n) {
  int best = arr[0];
  for(int i = 1; i < n; i++) {
    best = max(arr[i], best);
  }
  return best;
}

void countingSort(int arr[], int n, int place) {
  int max = 10;
  int output[n];
  int count[n];
  
  for (int i = 0; i < max; i++) count[i] = 0;
  
  for (int i = 0; i < n; i++) {
    count[arr[i] / place % max]++;
  }
  
  for (int i = 1; i < max; i++) {
    count[i] += count[i - 1];
  }
  
  for (int i = n - 1; i >= 0; i--) {
    output[count[arr[i] / place % max] - 1] = arr[i];
    count[arr[i] / place % max]--;
  }
  
  for (int i = 0; i < n; i++) {
    arr[i] = output[i];
  }
}

void print(int arr[], int n) {
  for (int i=0; i<n; i++)
    cout << arr[i] << " ";
}

int main() {
  int arr[] = {56, 5, 1, 86, 5, 13, 72, 99, 43};
  int n = sizeof(arr) / sizeof(arr[0]);
  
  cout << "Before Sorting: ";
  print(arr, n);
  
  int _max = getMax(arr, n);
  for (int place = 1; _max / place > 0; place *= 10) {
    countingSort(arr, n, place);
  }
  
  cout << "\\nAfter Sorting: ";
  print(arr, n);
  
  return 0;
}
    """;
  }

  String cocktailSortCode() {
    return """
#include <bits/stdc++.h>
using namespace std;

void cocktailSort(int arr[], int n) {
  bool isSwapped = true;
  int start = 0;
  int end = n;
  
  while (isSwapped) {
    isSwapped = false;
    for (int i = start; i < end - 1; i++) {
      if (_numbers[i] > _numbers[i + 1]) {
        swap(arr[i], arr[i+1]);
        isSwapped = true;
      }
    }
    
    if (!isSwapped) break;
    
    isSwapped = false;
    end = end - 1;
    
    for (int i = end - 1; i >= start; i--) {
      if (arr[i] > arr[i + 1]) {
        swap(arr[i], arr[i+1]);
        isSwapped = true;
      }
    }
    start = start + 1;
  }
}
  
void print(int arr[], int n) {
  for (int i = 0; i < n; i++)
    cout << arr[i] << " ";
}

int main() {
  int arr[] = {10, 20, 10, 90, 30, 80, 70, 45};
  int n = sizeof(arr) / sizeof(arr[0]);
  
  cout << "Before Sorting: ";
  print(arr, n);
  
  cocktailSort(arr, n);
  
  cout << "\\nAfter Sorting: ";
  print(arr, n);
  
  return 0;
}
    """;
  }

  String oddEvenSortCode() {
    return """
#include <bits/stdc++.h>
using namespace std;

void oddEvenSort(int arr[], int n) {
  bool isSorted = false;
  
  while (!isSorted) {
    isSorted = true;
    
    for (int i = 1; i <= n - 2; i += 2) {
      if (arr[i] > arr[i + 1]) {
        swap(arr[i], arr[i+1]);
        isSorted = false;
      }
    }
    
    for (int i = 0; i <= n - 2; i += 2) {
      if (arr[i] > arr[i + 1]) {
        swap(arr[i], arr[i+1]);
        isSorted = false;
      }
    }
  }
}

void print(int arr[], int n) {
  for (int i = 0; i < n; i++)
    cout << arr[i] << " ";
}

int main() {
  int arr[] = {10, 20, 10, 90, 30, 80, 70, 45};
  int n = sizeof(arr) / sizeof(arr[0]);
  
  cout << "Before Sorting: ";
  print(arr, n);
  
  oddEvenSort(arr, n);
  
  cout << "\\nAfter Sorting: ";
  print(arr, n);
  
  return 0;
}
    """;
  }

  String heapSortCode() {
    return """
#include <bits/stdc++.h>
using namespace std;

void heapSort(int arr[], int n) {
  for (int i = n / 2; i >= 0; i--) {
    heapify(arr, n, i);
  }
  
  for (int i = n - 1; i >= 0; i--) {
    swap(arr[0], arr[i]);
    heapify(arr, i, 0);
  }
}

void heapify(int arr[], int n, int i) {
  
  int largest = i;
  int l = 2 * i + 1;
  int r = 2 * i + 2;
  
  if (l < n && arr[l] > arr[largest]) largest = l;
  if (r < n && arr[r] > arr[largest]) largest = r;
  
  if (largest != i) {
    swap(arr[i], arr[largest]);
    heapify(arr, n, largest);
  }
}
  
void print(int arr[], int n) {
  for (int i = 0; i < n; i++)
    cout << arr[i] << " ";
}

int main() {
  int arr[] = {10, 20, 10, 90, 30, 80, 70, 45};
  int n = sizeof(arr) / sizeof(arr[0]);
  
  cout << "Before Sorting: ";
  print(arr, n);
  
  heapSort(arr, n);
  
  cout << "\\nAfter Sorting: ";
  print(arr, n);
  
  return 0;
}
    """;
  }

  String shellSortCode() {
    return """
#include<bits/stdc++.h>
using namespace std;

void shellSort(int arr[], int n) {
  for (int gap = n / 2; gap > 0; gap /= 2) {
    for (int i = gap; i < n; i++) {
      int temp = arr[i];
      int j;
      for (j = i; j >= gap && arr[j - gap] > temp; j -= gap)
        arr[j] = arr[j - gap];
        
      arr[j] = temp;
    }
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
  
  shellSort(arr, n);
  
  cout << "\\nAfter Sorting: ";
  print(arr, n);
  
  return 0;
} 
    """;
  }
}
