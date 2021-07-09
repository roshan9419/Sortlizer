enum AlgorithmType {
  BUBBLE_SORT,
  INSERTION_SORT,
  SELECTION_SORT,
  MERGE_SORT,
  QUICK_SORT,
  CYCLE_SORT,
  BOGO_SORT
}

String getAlgoTypeName(AlgorithmType type) {
  return type.toString().substring(type.toString().indexOf('.') + 1);
}
