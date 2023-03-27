import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoryNumberProvider extends ChangeNotifier {
  final SharedPreferences _prefs;
  static const _myNumberKey = 'myNumber';

  StoryNumberProvider(this._prefs);

  int _number = 0;

  Future<void> loadNumber() async {
    _number = _prefs.getInt(_myNumberKey) ?? 0;
    notifyListeners();
  }

  int get number => _number;

  set number(int value) {
    _number = value;
    _prefs.setInt(_myNumberKey, value);
    notifyListeners();
  }
}
