import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoryImages extends ChangeNotifier {
  final SharedPreferences _prefs;
  StoryImages(this._prefs);
}
