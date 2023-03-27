import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/data_provider.dart';
import 'package:instagram/view_story.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story/story_page_view.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  XFile? profileImage;
  final List<File?> listLocalImageStory = List.generate(100, (index) => null);

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      MyData.userName = prefs.getString('userName') ?? 'userName';
      final imagePath = prefs.getString('image_path');
      if (imagePath != null && imagePath.isNotEmpty) {
        profileImage = XFile(imagePath);
      }

      MyData.storyCount = prefs.getInt('storyCount');
    });
  }

  getDataStory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      for (var i = 0; i < 1000; i++) {
        final key = 'image_story_$i';
        if (prefs.containsKey(key)) {
          listLocalImageStory[i] = File(prefs.getString(key)!);
        }
      }
    });
  }

  @override
  void initState() {
    getData();
    getDataStory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StoryPageView(
            backgroundColor: Colors.black,
            indicatorHeight: 1.5,
            indicatorDuration: const Duration(seconds: 15),
            indicatorPadding: const EdgeInsets.symmetric(vertical: 32, horizontal: 8),
            itemBuilder: (context, pageIndex, storyIndex) {
              return Stack(
                children: [
                  Container(
                    //! Background
                    decoration: BoxDecoration(
                      image: listLocalImageStory[storyIndex] != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                File(listLocalImageStory[storyIndex]!.path),
                              ),
                            )
                          : const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/image/1.jpg'),
                            ),
                    ),
                  ),
                  //! Name & Avatar
                  Padding(
                    padding: const EdgeInsets.only(top: 44, left: 8),
                    child: Row(
                      children: [
                        profileImage == null || profileImage!.path.isEmpty
                            ? Container(
                                height: 32,
                                width: 32,
                                decoration: const BoxDecoration(
                                  color: Colors.pink,
                                  shape: BoxShape.circle,
                                ),
                              )
                            : Container(
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(File(profileImage!.path)),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                        const SizedBox(width: 8),
                        Text(
                          MyData.userName ?? "userName",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          '47m',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            storyLength: (int pageIndex) {
              return MyData.storyCount ?? 1000;
            },
            pageLength: 1,
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ViewStory(length: listLocalImageStory.length)),
                            );
                          },
                          child: Stack(children: [
                            Positioned(
                              left: 20,
                              top: 10,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.amber,
                                  border: Border.all(color: Colors.black87, width: 2),

                                  // image: DecorationImage(
                                  //   image: AssetImage('assets/image/1.jpg'),
                                  //   fit: BoxFit.cover,
                                  // ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 40,
                              top: 10,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.indigo,
                                  border: Border.all(color: Colors.black87, width: 2),

                                  // image: DecorationImage(
                                  //   image: AssetImage('assets/image/1.jpg'),
                                  //   fit: BoxFit.cover,
                                  // ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 60,
                              top: 10,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.lightGreen,
                                  border: Border.all(color: Colors.black87, width: 2),
                                  // image: DecorationImage(
                                  //   image: AssetImage('assets/image/1.jpg'),
                                  //   fit: BoxFit.cover,
                                  // ),
                                ),
                              ),
                            ),
                            const Positioned(
                              top: 47,
                              left: 37,
                              child: Text(
                                'Activity',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ]),
                        ),
                        const Positioned(
                          top: 10,
                          left: 180,
                          child: IconStory(
                            icon: Icons.movie_creation_outlined,
                            title: 'Create',
                          ),
                        ),
                        const Positioned(
                          top: 10,
                          left: 230,
                          child: IconStory(
                            icon: Icons.share,
                            title: 'Share to...',
                          ),
                        ),
                        const Positioned(
                          top: 10,
                          left: 290,
                          child: IconStory(
                            icon: Icons.highlight,
                            title: 'Highlight',
                          ),
                        ),
                        const Positioned(
                          top: 10,
                          left: 350,
                          child: IconStory(
                            icon: Icons.more_vert_sharp,
                            title: 'More',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IconStory extends StatelessWidget {
  final IconData icon;
  final String title;
  const IconStory({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 25,
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
