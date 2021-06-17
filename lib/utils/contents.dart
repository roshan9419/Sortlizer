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
}
