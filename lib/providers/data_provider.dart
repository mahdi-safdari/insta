import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataProvider extends ChangeNotifier {
  final SharedPreferences _prefs;
  DataProvider(this._prefs);

  static const _linkKey = 'link';
  static const _sumStickerKey = 'sumSticker';
  static const _tap1Key = 'tap1';
  static const _tap2Key = 'tap2';
  static const _tap3Key = 'tap3';
  static const _nameTap1Key = 'nameTap1';
  static const _nameTap2Key = 'nameTap2';
  static const _nameTap3Key = 'nameTap3';
  static const _linkProfileKey = 'linkProfile';

  int _link = 0;
  int _sumSticker = 0;
  int _tap1 = 0;
  int _tap2 = 0;
  int _tap3 = 0;
  String _nameTap1 = 'sticker_taps1';
  String _nameTap2 = 'sticker_taps2';
  String _nameTap3 = 'sticker_taps3';
  String _linkProfile = 'link';

  Future<void> loadDataProvider() async {
    _link = _prefs.getInt(_linkKey) ?? 0;
    _sumSticker = _prefs.getInt(_sumStickerKey) ?? 0;
    _tap1 = _prefs.getInt(_tap1Key) ?? 0;
    _tap2 = _prefs.getInt(_tap2Key) ?? 0;
    _tap3 = _prefs.getInt(_tap3Key) ?? 0;
    _nameTap1 = _prefs.getString(_nameTap1Key) ?? 'sticker_taps1';
    _nameTap2 = _prefs.getString(_nameTap2Key) ?? 'sticker_taps2';
    _nameTap3 = _prefs.getString(_nameTap3Key) ?? 'sticker_taps3';
    _linkProfile = _prefs.getString(_linkProfileKey) ?? 'link';
    notifyListeners();
  }

  int get link => _link;
  int get sumSticker => _sumSticker;
  int get tap1 => _tap1;
  int get tap2 => _tap2;
  int get tap3 => _tap3;
  String get nameTap1 => _nameTap1;
  String get nameTap2 => _nameTap2;
  String get nameTap3 => _nameTap3;
  String get linkProfile => _linkProfile;

  set link(int value) {
    _link = value;
    _prefs.setInt(_linkKey, value);
    notifyListeners();
  }

  set sumSticker(int value) {
    _sumSticker = value;
    _prefs.setInt(_sumStickerKey, value);
    notifyListeners();
  }

  set tap1(int value) {
    _tap1 = value;
    _prefs.setInt(_tap1Key, value);
    notifyListeners();
  }

  set tap2(int value) {
    _tap2 = value;
    _prefs.setInt(_tap2Key, value);
    notifyListeners();
  }

  set tap3(int value) {
    _tap3 = value;
    _prefs.setInt(_tap3Key, value);
    notifyListeners();
  }

  set nameTap1(String value) {
    _nameTap1 = value;
    _prefs.setString(_nameTap1Key, value);
    notifyListeners();
  }

  set nameTap2(String value) {
    _nameTap2 = value;
    _prefs.setString(_nameTap2Key, value);
    notifyListeners();
  }

  set nameTap3(String value) {
    _nameTap3 = value;
    _prefs.setString(_nameTap3Key, value);
    notifyListeners();
  }

  set linkProfile(String value) {
    _linkProfile = value;
    _prefs.setString(_linkProfileKey, value);
    notifyListeners();
  }
}
