import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/my_data.dart';
import 'package:instagram/providers/avatar_provider.dart';
import 'package:instagram/providers/story_number_provider.dart';
import 'package:instagram/user_view.dart';
import 'package:instagram/view_story.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story/story_page_view.dart';

class StoryPage extends StatefulWidget {
  final int initialStoryIndex;
  const StoryPage({super.key, required this.initialStoryIndex});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  final List<File?> listLocalImageStory = List.generate(100, (index) => null);

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      MyData.userName = prefs.getString('userName') ?? 'userName';
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

  int storyIndex = 0;
  @override
  Widget build(BuildContext context) {
    final avatar = Provider.of<AvatarProvider>(context);
    final storyCount = Provider.of<StoryNumberProvider>(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: StoryPageView(
              initialStoryIndex: (pageIndex) {
                return widget.initialStoryIndex;
              },
              backgroundColor: Colors.black,
              indicatorHeight: 1.5,
              indicatorDuration: const Duration(seconds: 15),
              indicatorPadding: const EdgeInsets.symmetric(vertical: 32, horizontal: 8),
              onPageChanged: (int index) {
                setState(() {
                  storyIndex = index;
                });
              },
              itemBuilder: (context, pageIndex, storyIndex) {
                return Container(
                  color: Colors.black,
                  child: Stack(
                    children: [
                      //! Background
                      Hero(
                        tag: storyIndex,
                        child: Container(
                          margin: const EdgeInsets.only(top: 20),
                          height: size.height * 0.875,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
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
                      ),
                      Container(
                        height: 30,
                        decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 100,
                            spreadRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ]),
                      ),

                      //! Name & Avatar
                      Padding(
                        padding: const EdgeInsets.only(top: 44, left: 8),
                        child: Row(
                          children: [
                            avatar.profileImage == null || avatar.profileImage!.path.isEmpty
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
                                        image: FileImage(File(avatar.profileImage!.path)),
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
                                shadows: [
                                  Shadow(
                                    color: Colors.grey,
                                    blurRadius: 2,
                                  ),
                                ],
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
                  ),
                );
              },
              storyLength: (int pageIndex) {
                return storyCount.number;
              },
              pageLength: 1,
            ),
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
                              MaterialPageRoute(builder: (context) => ViewStory(storyIndex: storyIndex, length: listLocalImageStory.length)),
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
                                  border: Border.all(color: Colors.black87, width: 2),
                                  image: DecorationImage(
                                    image: NetworkImage('https://randomuser.me/api/portraits/${RandomImage.gender[Random().nextInt(2)]}/${Random().nextInt(100)}.jpg'),
                                    fit: BoxFit.cover,
                                  ),
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
                                  border: Border.all(color: Colors.black87, width: 2),
                                  image: DecorationImage(
                                    image: NetworkImage('https://randomuser.me/api/portraits/${RandomImage.gender[Random().nextInt(2)]}/${Random().nextInt(100)}.jpg'),
                                    fit: BoxFit.cover,
                                  ),
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
                                  border: Border.all(color: Colors.black87, width: 2),
                                  image: DecorationImage(
                                    image: NetworkImage('https://randomuser.me/api/portraits/${RandomImage.gender[Random().nextInt(2)]}/${Random().nextInt(100)}.jpg'),
                                    fit: BoxFit.cover,
                                  ),
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
                        Positioned(
                          top: 10,
                          left: 180,
                          child: IconStory(
                            icon: SvgPicture.asset('assets/svg/reel.svg', color: Colors.white),
                            title: 'Create',
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 230,
                          child: IconStory(
                            icon: SvgPicture.asset('assets/image/share.svg', color: Colors.white),
                            title: 'Share to...',
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 290,
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  SvgPicture.asset('assets/svg/highlights.svg', width: 25, height: 25, color: Colors.white),
                                  SvgPicture.asset('assets/svg/heart1.svg', width: 10, height: 10, color: Colors.white),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Highlight',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Positioned(
                          top: 10,
                          left: 350,
                          child: IconStory(
                            icon: Icon(Icons.more_vert_sharp, color: Colors.white),
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
  final Widget icon;
  final String title;
  const IconStory({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(width: 25, height: 25, child: icon),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
