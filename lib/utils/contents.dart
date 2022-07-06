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
    AlgorithmType.SHELL_SORT: "Shell Sort",
    AlgorithmType.BEAD_SORT: "Bead Sort",
    AlgorithmType.GNOME_SORT: "Gnome Sort"
  };

  String getAlgorithmTitle(AlgorithmType type) {
    return algorithmsMap[type]!;
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
          "Bubble Sort is the simplest sorting algorithm that works by repeatedly swapping the adjacent elements of the array if they are in the wrong order.\n\n" +
              "Eg., arr[2] = 12 & arr[3] = 5\n" +
              "Now, arr[2] > arr[3], so swap: arr[2] = 5 & arr[3] = 12",
      AlgorithmType.INSERTION_SORT:
          "Insertion Sort is a simple sorting algorithm that builds the sorted array one element at a time. The elements from the unsorted part are picked and placed at the correct position in the sorted part.",
      AlgorithmType.SELECTION_SORT:
          "The selection sort algorithm sorts an array by repeatedly finding the minimum element from the unsorted part and putting it at the beginning of the array.",
      AlgorithmType.MERGE_SORT:
          "Merge Sort is a divide and conquer algorithm. Which first divides the given input array into two halves, calling itself for the two halves, and then merging the two sorted halves.",
      AlgorithmType.QUICK_SORT:
          "QuickSort is a divide and conquer algorithm, which picks an element from the given array as a pivot and partitions the given array around the chosen pivot.",
      AlgorithmType.CYCLE_SORT:
          "Cycle sort is an in-place sorting algorithm, unstable sorting algorithm, a comparison sort that is theoretically optimal in terms of the total number of writes to the original array, unlike any other in-place sorting algorithm.",
      AlgorithmType.BOGO_SORT:
          "BogoSort is also known as permutation sort, stupid sort, slow sort, shotgun sort or monkey sort is a particularly ineffective algorithm based on generating and test paradigm. The algorithm successively generates permutations of its input until it finds one that is sorted. It is not useful for sorting but may be used for educational purposes, it is used as a kind of joke.",
      AlgorithmType.RADIX_SORT:
          "Radix sort is a sorting algorithm that avoids comparison and sorts the elements by first grouping or creating buckets of the individual digits of the same place value. Then, sorting the elements according to their increasing/decreasing order.",
      AlgorithmType.COCKTAIL_SORT:
          "Cocktail Sort is a variation of Bubble sort. The Bubble sort algorithm always traverses elements from left and moves the largest element to its correct position in the first iteration and second-largest in the second iteration and so on. Cocktail Sort traverses through a given array in both directions alternatively.",
      AlgorithmType.ODD_EVEN_SORT:
          "Odd-Even sort algorithm is divided into two phases - Odd and the Even Phase. The algorithm runs until the array elements are sorted and in each iteration, two phases occur- Odd and Even Phases. In the odd phase, we perform a bubble sort on odd indexed elements, and in the even phase, we perform a bubble sort on even indexed elements.",
      AlgorithmType.HEAP_SORT:
          "Heap Sort is a comparison-based sorting technique based on Binary Heap data structure. It is similar to selection sort but much improved where it maintains the unsorted region in a heap data structure to more quickly find the largest element in each step and place the element at the end.",
      AlgorithmType.SHELL_SORT:
          "Shell sort is a generalized version of the insertion sort algorithm. It first sorts elements that are far apart from each other and successively reduces the interval between the elements to be sorted.",
      AlgorithmType.BEAD_SORT:
          "Also known as Gravity sort, this algorithm was inspired by natural phenomenons and was designed keeping in mind-objects (or beads) falling under the influence of gravity. Both digital and analog hardware implementations of bead sort can achieve a sorting time of O(n); however, the implementation of this algorithm tends to be significantly slower in software and can only be used to sort lists of positive integers.",
      AlgorithmType.GNOME_SORT:
          "Gnome Sort is a sorting algorithm that is similar to Insertion sort in that it works with one item at a time but gets the item to the proper place by a series of swaps, similar to a Bubble sort."
    };

    return algoDesc.containsKey(type) ? algoDesc[type]! : "N.A";
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
      // AlgorithmType.BEAD_SORT: ["O(S)", "O(√n)", "O(1)"],
      AlgorithmType.GNOME_SORT: ["O(n²)", "O(n²)", "O(n)"],
    };
    return complexities.containsKey(type)
        ? complexities[type]!
        : ["N.A.", "N.A.", "N.A."];
  }

  String getSpaceComplexity(AlgorithmType type) {
    // Worst Cases
    var complexities = {
      AlgorithmType.BUBBLE_SORT: "O(1)",
      AlgorithmType.INSERTION_SORT: "O(1)",
      AlgorithmType.SELECTION_SORT: "O(1)",
      AlgorithmType.MERGE_SORT: "O(n)",
      AlgorithmType.QUICK_SORT: "O(logn)",
      AlgorithmType.CYCLE_SORT: "O(1)",
      AlgorithmType.BOGO_SORT: "O(1)",
      AlgorithmType.RADIX_SORT: "O(n+k)",
      AlgorithmType.COCKTAIL_SORT: "O(1)",
      AlgorithmType.ODD_EVEN_SORT: "O(1)",
      AlgorithmType.HEAP_SORT: "O(1)",
      AlgorithmType.SHELL_SORT: "O(1)",
      AlgorithmType.BEAD_SORT: "O(n²)",
      AlgorithmType.GNOME_SORT: "O(1)",
    };
    return complexities.containsKey(type) ? complexities[type]! : "N.A";
  }

  String algoExtraInfo(AlgorithmType type) {
    if (type == AlgorithmType.BEAD_SORT) {
      return "4 general levels of complexity:\n\n" +
          "1. O(1): Beads moved simultaneously as a single operation. This complexity cannot be implemented in practice.\n" +
          "2. O(√n): In a realistic physical model that uses gravity, the time it takes to let the beads fall is proportional to the square root of the maximum height, which is proportional to n.\n" +
          "3. O(n): Dropping the row of beads in the frame (representing a number) as a distinct operation since the number of rows is equal to n.\n" +
          "4. O(S): S is the sum of all the beads. Each bead is moved separately.";
    }
    return "";
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
      case AlgorithmType.BEAD_SORT:
        return beadSortCode();
      case AlgorithmType.GNOME_SORT:
        return gnomeSortCode();
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
  for (int i = 0; i < n - 1; i++) {
    int minIdx = i;
    for (int j = i + 1; j < n; j++) {
      if(arr[j] < arr[minIdx])
        minIdx = j;
    }
    swap(arr[i], arr[minIdx]);
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
	int arr[] = {12, 42, 32, 4, 2, 55, 32, 56, 23};
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
		quickSort(arr, start, pIndex-1);
		quickSort(arr, pIndex+1, end);
	}
}

void print(int a[], int n) {
	for(int i=0; i<n; i++)
	  cout << a[i] << " ";
}

int main() {
	int arr[] = {2, 10, 9, 3, 5, 8, 6, 7, 1, 4};
	int n = sizeof(arr) / sizeof(arr[0]);
	
	cout << "Before Sorting: ";
	print(arr, n);
	
	quickSort(arr, 0, n-1);
	
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

void shuffleArray(int arr[], int n) {
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
    shuffleArray(arr, n);
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
      
      if (item != arr[pos]) {
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
      if (arr[i] > arr[i + 1]) {
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

void heapSort(int arr[], int n) {
  for (int i = n / 2; i >= 0; i--) {
    heapify(arr, n, i);
  }
  
  for (int i = n - 1; i >= 0; i--) {
    swap(arr[0], arr[i]);
    heapify(arr, i, 0);
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

  String beadSortCode() {
    return """
#include<bits/stdc++.h>
using namespace std;

void beadSort(int arr[], int n) {
  int _max = arr[0];
  for (int i = 0; i < n; i++) {
    _max = max(arr[i], _max);
  }
  
  int grid[n][_max];
  int levelCount[_max];
  
  for (int i = 0; i < _max; i++) {
    levelCount[i] = 0;
    for (int j = 0; j < n; j++) {
      grid[j][i] = 0; // Not Marked
    }
  }
  
  for (int i = 0; i < n; i++) {
    int num = arr[i];
    for (int j = 0; num > 0; j++, num--) {
      grid[levelCount[j]++][j] = 1; // Marked
    }
  }
  
  for (int i = 0; i < n; i++) {
    int putt = 0;
    for (int j = 0; j < _max && grid[n - 1 - i][j] == 1; j++) {
      putt++;
    }    
    arr[i] = putt;
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
  
  beadSort(arr, n);
  
  cout << "\\nAfter Sorting: ";
  print(arr, n);
  
  return 0;
}
    """;
  }

  String gnomeSortCode() {
    return """
#include<bits/stdc++.h>
using namespace std;

void gnomeSort(int arr[], int n) {
  int index = 0;
  while (index < n) {
    if (index == 0) index++;
    if (arr[index] >= arr[index - 1]) index++;
    else {
      swap(arr[index], arr[index-1]);
      index--;
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
  
  gnomeSort(arr, n);
  
  cout << "\\nAfter Sorting: ";
  print(arr, n);
  
  return 0;
}
    """;
  }
}
