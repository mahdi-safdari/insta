import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoryNumberProvider extends ChangeNotifier {
  final SharedPreferences _prefs;
  StoryNumberProvider(this._prefs);

  static const _myNumberKey = 'myNumber';
  static const _gridKey = 'grid';
  int _number = 0;
  int _grid = 1;

  Future<void> loadNumber() async {
    _number = _prefs.getInt(_myNumberKey) ?? 0;
    _grid = _prefs.getInt(_gridKey) ?? 1;
    notifyListeners();
  }

  int get number => _number;
  int get grid => _grid;

  set number(int value) {
    _number = value;
    _prefs.setInt(_myNumberKey, value);
    notifyListeners();
  }

  set grid(int value) {
    _grid = value;
    _prefs.setInt(_gridKey, value);
    notifyListeners();
  }
}
