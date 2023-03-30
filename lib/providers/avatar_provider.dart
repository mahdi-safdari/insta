import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvatarProvider extends ChangeNotifier {
  final SharedPreferences _prefs;
  AvatarProvider(this._prefs);

  static const _avatarKey = 'avatar';
  XFile? _profileImage;
  final ImagePicker _picker = ImagePicker();
  XFile? get profileImage => _profileImage;

  Future<void> loadAvatar() async {
    final imagePath = _prefs.getString(_avatarKey) ?? "";
    if (imagePath != null && imagePath.isNotEmpty) {
      _profileImage = XFile(imagePath);
    }
    notifyListeners();
  }

  Future<void> getProfileImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    //! Save the image file to local storage
    final Directory tempDir = await getApplicationDocumentsDirectory();
    final String fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
    final File localImage = await File('${tempDir.path}/$fileName').create();
    final bytes = await image.readAsBytes();
    await localImage.writeAsBytes(bytes);

    //! Save the path to the stored image file in SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('avatar', localImage.path);

    //! Set the profileImage variable with the stored image path
    _profileImage = XFile(localImage.path);

    notifyListeners();
  }
}
