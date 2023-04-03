import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoryImagesProvider extends ChangeNotifier {
  final SharedPreferences _prefs;
  StoryImagesProvider(this._prefs);

  final List<File?> _listLocalImageStory = List.generate(1000, (_) => null);
  final ImagePicker _picker = ImagePicker();

  List<File?> get listLocalImageStory => _listLocalImageStory;

  Future<void> saveDataStory({required int index, required String imagePath}) async {
    final key = 'image_story_$index';
    _prefs.setString(key, imagePath);
  }

  Future<void> getImageStory(int index) async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    final Directory tempDir = await getApplicationDocumentsDirectory();

    if (image != null && index >= 0) {
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}_${index * pi}.png';
      final File localImage = await File('${tempDir.path}/$fileName').create();
      final byteData = await image.readAsBytes();
      final bytes = byteData.buffer.asUint8List();
      await localImage.writeAsBytes(bytes);

      _listLocalImageStory[index] = localImage;
      await saveDataStory(index: index, imagePath: localImage.path);
      notifyListeners();
    }
  }

  Future<void> getDataStory() async {
    for (var i = 0; i < 1000; i++) {
      final key = 'image_story_$i';
      if (_prefs.containsKey(key)) {
        _listLocalImageStory[i] = File(_prefs.getString(key)!);
      }
    }
    notifyListeners();
  }
}
