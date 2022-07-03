
library win_prefs;

import 'dart:convert';
import 'dart:io';

Preferences prefs = Preferences();

class Preferences {

  bool formatted = false;

  final Map<String, dynamic> _values = {};
  String? _fileName;

  // #region int, double, string, bool

  void putInt(String key, int value) => _values[key] = value;
  void putDouble(String key, double value) => _values[key] = value;
  void putString(String key, String value) => _values[key] = value;
  void putBool(String key, bool value) => _values[key] = value;

  int getInt(String key, [int defaultValue = 0]) {
    dynamic value = _values[key];
    return value is int ? value : defaultValue;
  }

  double getDouble(String key, [double defaultValue = 0]) {
    dynamic value = _values[key];
    return value is double ? value : defaultValue;
  }

  String getString(String key, [String defaultValue = '']) {
    dynamic value = _values[key];
    return value is String ? value : defaultValue;
  }

  bool getBool(String key, [bool defaultValue = false]) {
    dynamic value = _values[key];
    return value is bool ? value : defaultValue;
  }

  // #endregion

  // #region arrays

  void putIntArray(String key, List<int> array) => _values[key] = array;
  void putDoubleArray(String key, List<double> array) => _values[key] = array;
  void putStringArray(String key, List<String> array) => _values[key] = array;
  void putBoolArray(String key, List<bool> array) => _values[key] = array;

  List<int> getIntArray(String key) {
    dynamic value = _values[key];
    return value is List<int> ? value : [];
  }

  List<double> getDoubleArray(String key) {
    dynamic value = _values[key];
    return value is List<double> ? value : [];
  }

  List<String> getStringArray(String key) {
    dynamic value = _values[key];
    return value is List<String> ? value : [];
  }

  List<bool> getBoolArray(String key) {
    dynamic value = _values[key];
    return value is List<bool> ? value : [];
  }

  // #endregion

  // #region open, close

  void open(String fileName) {

    if(_fileName != null) close();

    _fileName = fileName;

    File file = File(fileName);
    if(!file.existsSync()) return;

    String json = file.readAsStringSync();
    _values.addAll(JsonDecoder().convert(json));

  }

  void close() {

    if(_fileName == null) return;

    File file = File(_fileName!);

    JsonEncoder encoder = formatted ? JsonEncoder.withIndent('\t') : JsonEncoder();
    String json = encoder.convert(_values);
    file.writeAsStringSync(json);

    _values.clear();
    _fileName = null;

  }

  // #endregion

}
