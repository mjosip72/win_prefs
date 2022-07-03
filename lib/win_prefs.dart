
library win_prefs;

import 'dart:convert';
import 'dart:io';

Preferences prefs = Preferences();

class Preferences {

  final Map<String, dynamic> _values = {};
  String? _fileName;

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

  void open(String fileName) {

    if(_fileName != null) close();

    _fileName = fileName;

    File file = File(fileName);
    if(file.existsSync()) _values.addAll(jsonDecode(file.readAsStringSync()));

  }

  void close() {

    if(_fileName == null) return;

    File file = File(_fileName!);
    file.writeAsStringSync(jsonEncode(_values));

    _values.clear();
    _fileName = null;

  }

}
