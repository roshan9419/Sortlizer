enum AlgorithmType {
  BUBBLE_SORT,
  INSERTION_SORT,
  SELECTION_SORT,
  MERGE_SORT,
  QUICK_SORT,
  CYCLE_SORT,
  BOGO_SORT,
  RADIX_SORT,
  COCKTAIL_SORT,
  ODD_EVEN_SORT,
  HEAP_SORT,
  SHELL_SORT,
  BEAD_SORT,
  GNOME_SORT
}

String getAlgoTypeName(AlgorithmType type) {
  return type.toString().substring(type.toString().indexOf('.') + 1);
}

AlgorithmType getAlgoTypeFromString(String strType) {
  return AlgorithmType.values.firstWhere((e) => e.toString() == strType);
}