import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/providers/story_number_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;

class AccountTab1 extends StatefulWidget {
  const AccountTab1({super.key});

  @override
  State<AccountTab1> createState() => _AccountTab1State();
}

class _AccountTab1State extends State<AccountTab1> {
  Future<void> saveData({required int index, required String imagePath}) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'image_path_$index';
    prefs.setString(key, imagePath);
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      for (var i = 0; i < 500; i++) {
        final key = 'image_path_$i';
        if (prefs.containsKey(key)) {
          listLocalImages[i] = File(prefs.getString(key)!);
        }
      }
    });
  }

  final List<File?> listLocalImages = List.generate(500, (_) => null);
  final ImagePicker _picker = ImagePicker();

  getImagePost(int index) async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    final Directory tempDir = await getApplicationDocumentsDirectory();

    if (image != null && index >= 0) {
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}_${index + 1}.png';
      final File localImage = await File('${tempDir.path}/$fileName').create();
      final byteData = await image.readAsBytes();
      final bytes = byteData.buffer.asUint8List();
      await localImage.writeAsBytes(bytes);

      setState(() {
        listLocalImages[index] = localImage;
        saveData(index: index, imagePath: localImage.path);
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final grid = Provider.of<StoryNumberProvider>(context);
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: grid.grid,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(1.5),
          child: GestureDetector(
            onLongPress: () {
              getImagePost(index);
            },
            child: listLocalImages[index] != null
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(File(listLocalImages[index]!.path)),
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
