import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SliderProvider extends ChangeNotifier {
  final SharedPreferences _prefs;
  SliderProvider(this._prefs);

  static const _followerKey = 'follower';
  static const _nonFollowerKey = 'nonFollower';
  int _follower = 0;
  int _nonFollower = 0;

  Future<void> loadSliderNumber() async {
    _follower = _prefs.getInt(_followerKey) ?? 0;
    _nonFollower = _prefs.getInt(_nonFollowerKey) ?? 0;
    notifyListeners();
  }

  int get follower => _follower;
  int get nonFollower => _nonFollower;

  set follower(int value) {
    _follower = value;
    _prefs.setInt(_followerKey, value);
    notifyListeners();
  }

  set nonFollower(int value) {
    _nonFollower = value;
    _prefs.setInt(_nonFollowerKey, value);
    notifyListeners();
  }
}
