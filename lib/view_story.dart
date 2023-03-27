import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/over_view.dart';
import 'package:instagram/story_page.dart';
import 'package:instagram/user_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewStory extends StatefulWidget {
  final int length;
  const ViewStory({super.key, required this.length});

  @override
  State<ViewStory> createState() => _ViewStoryState();
}

class _ViewStoryState extends State<ViewStory> {
  PageController controller1 = PageController(viewportFraction: 0.17, initialPage: 0);
  PageController controller2 = PageController(initialPage: 0);
  var currentPageValue = 0.0;

  final List<File?> listLocalImageStory = List.generate(1000, (index) => null);

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
    getDataStory();
    super.initState();
    controller1.addListener(() {
      setState(() {
        currentPageValue = controller1.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const Icon(
          Icons.settings,
          size: 30,
          color: Colors.black,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.close,
              size: 30,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: SizedBox(
              height: 140,
              child: PageView.builder(
                itemCount: widget.length,
                scrollDirection: Axis.horizontal,
                controller: controller1,
                itemBuilder: (context, position) {
                  double scale = (1 - (currentPageValue - position).abs()) * 0.2 + 0.8;
                  if (currentPageValue != position) {
                    scale = scale.clamp(0.75, double.infinity);
                  }
                  return Transform.scale(
                    scale: scale,
                    child: GestureDetector(
                      onTap: () {
                        controller1.animateToPage(
                          position,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: GestureDetector(
                        onTap: currentPageValue == position
                            ? () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: const StoryPage(),
                                    type: PageTransitionType.scale,
                                    alignment: const Alignment(-0.01, -0.70),
                                    duration: const Duration(milliseconds: 500),
                                  ),
                                );
                              }
                            : null,
                        child: SizedBox(
                          child: listLocalImageStory[position] != null
                              ? Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                        File(listLocalImageStory[position]!.path),
                                      ),
                                    ),
                                  ),
                                )
                              : null,
                          // Container(
                          //     color: Colors.greenAccent,
                          //   ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: PageView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return const DetailStory();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DetailStory extends StatelessWidget {
  const DetailStory({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset.zero,
                  blurRadius: 20,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  bottom: 30,
                  left: size.width * 0.5 - 10,
                  child: Transform.rotate(
                    angle: 2.4,
                    child: Container(
                      width: 30,
                      height: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 38),
                  child: Divider(
                    color: Colors.grey.shade400,
                  ),
                ),
                Row(
                  children: const [
                    Expanded(
                      child: TabBar(
                        tabs: [
                          Tab(
                            height: 45,
                            icon: Icon(
                              Icons.view_week_rounded,
                              color: Colors.black,
                            ),
                          ),
                          Tab(
                            height: 45,
                            icon: Icon(Icons.remove_red_eye_outlined, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 150),
                    Icon(Icons.file_download_rounded),
                    SizedBox(width: 20),
                    Icon(Icons.ios_share_rounded),
                    SizedBox(width: 20),
                    Icon(Icons.delete_outline_rounded),
                    SizedBox(width: 20),
                  ],
                ),
              ],
            ),
          ),
          const Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                OverView(),
                UserView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InterestsModel {
  String imageAsset;
  String? title;
  InterestsModel({this.title, required this.imageAsset});
}
