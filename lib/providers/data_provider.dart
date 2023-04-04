import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataProvider extends ChangeNotifier {
  final SharedPreferences _prefs;
  DataProvider(this._prefs);

  static const _linkProfileKey = 'linkProfile';
  static const _indexTabBarKey = 'indexTabBar';

  String _linkProfile = 'link';
  int _indexTabBar = 0;

  Future<void> loadDataProvider() async {
    _linkProfile = _prefs.getString(_linkProfileKey) ?? 'link';
    _indexTabBar = _prefs.getInt(_indexTabBarKey) ?? 0;
    notifyListeners();
  }

  String get linkProfile => _linkProfile;
  int get indexTabBar => _indexTabBar;

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
}
