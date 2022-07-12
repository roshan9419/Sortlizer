enum BarType { DEFAULT_BAR, DOTS, HALF_HALF, REVERSE_BAR, SEQUENCE_BAR }

String getBarTypeName(BarType type) {
  return type.toString().substring(type.toString().indexOf('.') + 1);
}

BarType getBarTypeFromString(String strType) {
  return BarType.values.firstWhere((e) => getBarTypeName(e) == strType);
}
