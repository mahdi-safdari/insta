import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataProvider extends ChangeNotifier {
  final SharedPreferences _prefs;
  DataProvider(this._prefs);

  static const _linkProfileKey = 'linkProfile';
  static const _indexTabBarKey = 'indexTabBar';
  static const _textProfileKey = 'textProfile';

  String _linkProfile = 'link';
  int _indexTabBar = 0;
  String _textProfile = 'New tools are now available.';

  Future<void> loadDataProvider() async {
    _linkProfile = _prefs.getString(_linkProfileKey) ?? 'link';
    _indexTabBar = _prefs.getInt(_indexTabBarKey) ?? 0;
    _textProfile = _prefs.getString(_textProfileKey) ?? 'New tools are now available.';
    notifyListeners();
  }

  String get linkProfile => _linkProfile;
  int get indexTabBar => _indexTabBar;
  String get textProfile => _textProfile;

  set linkProfile(String value) {
    _linkProfile = value;
    _prefs.setString(_linkProfileKey, value);
    notifyListeners();
  }

  set indexTabBar(int value) {
    _indexTabBar = value;
    _prefs.setInt(_indexTabBarKey, value);
    notifyListeners();
  }

  set textProfile(String value) {
    _textProfile = value;
    _prefs.setString(_textProfileKey, value);
    notifyListeners();
  }
}
