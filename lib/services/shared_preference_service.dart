import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sorting_visualization/datamodels/barType.dart';

@lazySingleton
class SharedPreferenceService {
  late SharedPreferences _preferences;

  Future<void> initialise() async {
    _preferences = await SharedPreferences.getInstance();
    print('Shared Preference Initialized');
  }

  static const String APP_THEME = "appTheme";
  static const String ALGORITHM_SELECTED = "algorithmSelected";
  static const String SHOW_SORTING_HISTORY = "showSortingHistory";
  static const String SORTING_SLIDER_VALUE = "sortingSliderValue";
  static const String SORTING_ARRAY_SIZE = "sortingArraySize";
  static const String HOME_VISIBLE = "homeVisible";
  static const String SORTING_SOUND_ENABLED = "sortingSoundEnabled";
  static const String BAR_TYPE = "barType";
  static const String FLAG_MODE = "flagMode";

  // handles all types of values
  void _saveToDisk<T>(String key, T content) {
    if (content is String) {
      _preferences.setString(key, content);
    }
    if (content is bool) {
      _preferences.setBool(key, content);
    }
    if (content is int) {
      _preferences.setInt(key, content);
    }
    if (content is double) {
      _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }

  dynamic _getFromDisk(String key) {
    return _preferences.get(key);
  }

  clearData() async {
    await _preferences.clear();
  }

  bool get homeVisible => _getFromDisk(HOME_VISIBLE) ?? false;

  set homeVisible(bool value) => _saveToDisk(HOME_VISIBLE, value);

  bool get showSortingHistory => _getFromDisk(SHOW_SORTING_HISTORY) ?? true;

  set showSortingHistory(bool value) =>
      _saveToDisk(SHOW_SORTING_HISTORY, value);

  double get sortingSliderValue => _getFromDisk(SORTING_SLIDER_VALUE) ?? 0.0;

  set sortingSliderValue(double value) =>
      _saveToDisk(SORTING_SLIDER_VALUE, value);

  int get sortingArraySize => _getFromDisk(SORTING_ARRAY_SIZE) ?? 50;

  set sortingArraySize(int value) => _saveToDisk(SORTING_ARRAY_SIZE, value);

  String? get algorithmSelected => _getFromDisk(ALGORITHM_SELECTED);

  set algorithmSelected(String? value) =>
      _saveToDisk(ALGORITHM_SELECTED, value);

  bool get sortingSoundEnabled => _getFromDisk(SORTING_SOUND_ENABLED) ?? true;

  set sortingSoundEnabled(bool value) =>
      _saveToDisk(SORTING_SOUND_ENABLED, value);

  BarType get barType => getBarTypeFromString(
      _getFromDisk(BAR_TYPE) ?? getBarTypeName(BarType.DEFAULT_BAR));

  set barType(BarType value) => _saveToDisk(BAR_TYPE, getBarTypeName(value));

  bool get flagMode => _getFromDisk(FLAG_MODE) ?? false;

  set flagMode(bool value) => _saveToDisk(FLAG_MODE, value);
}
