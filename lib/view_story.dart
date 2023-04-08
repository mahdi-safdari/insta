import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/my_data.dart';
import 'package:instagram/over_view.dart';
import 'package:instagram/providers/avatar_provider.dart';
import 'package:instagram/providers/data_provider.dart';
import 'package:instagram/providers/story_data_provider.dart';
import 'package:instagram/providers/story_images_provider.dart';
import 'package:instagram/providers/story_number_provider.dart';
import 'package:instagram/story_page.dart';
import 'package:instagram/user_view.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewStory extends StatefulWidget {
  final int length;
  final int storyIndex;
  const ViewStory({super.key, required this.length, required this.storyIndex});

  @override
  State<ViewStory> createState() => _ViewStoryState();
}

class _ViewStoryState extends State<ViewStory> {
  PageController pageController1 = PageController(viewportFraction: 0.19, initialPage: 0);
  PageController pageController2 = PageController(initialPage: 0);
  var currentPageValue = 0.0;

  @override
  void initState() {
    super.initState();

    pageController1.addListener(() {
      setState(() {
        currentPageValue = pageController1.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController1.dispose();
    pageController2.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final storyNumber = Provider.of<StoryNumberProvider>(context);
    final avatar = Provider.of<AvatarProvider>(context);
    final storyProvider = Provider.of<StoryImagesProvider>(context);

    return Scaffold(
      //! App Bar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          SizedBox(child: SvgPicture.asset('assets/svg/Options.svg', width: 25, height: 25)),
          const SizedBox(width: 310),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SizedBox(
              width: 20,
              height: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: const StoryPage(initialStoryIndex: 0),
                      type: PageTransitionType.scale,
                      alignment: const Alignment(-0.01, -0.70),
                      duration: const Duration(milliseconds: 500),
                    ),
                  );
                },
                child: SvgPicture.asset('assets/image/cross.svg'),
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          //! Page view Story
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 140,
              child: PageView.builder(
                onPageChanged: (value) {
                  pageController2.jumpToPage(value);

                  pageController1.animateToPage(
                    value,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.linear,
                  );
                },
                physics: const BouncingScrollPhysics(),
                itemCount: storyNumber.number + 1,
                scrollDirection: Axis.horizontal,
                controller: pageController1,
                itemBuilder: (context, position) {
                  double scale = (1 - (currentPageValue - position).abs()) * 0.2 + 0.8;
                  if (currentPageValue != position) {
                    scale = scale.clamp(0.75, double.infinity);
                  }
                  //! last item story
                  if (position == storyNumber.number) {
                    return Transform.scale(
                      scale: scale,
                      child: GestureDetector(
                        onTap: () {
                          pageController1.animateToPage(
                            position,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear,
                          );
                        },
                        child: Container(
                          color: Colors.black,
                          child: const Icon(Icons.photo_camera_outlined, color: Colors.white, size: 40),
                        ),
                      ),
                    );
                  }
                  return Hero(
                    tag: position,
                    child: Transform.scale(
                      scale: scale,
                      child: GestureDetector(
                        onTap: () {
                          pageController2.jumpToPage(position);
                          pageController1.animateToPage(
                            position,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.linear,
                          );
                        },
                        child: GestureDetector(
                          onTap: currentPageValue == position
                              ? () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      child: StoryPage(initialStoryIndex: position),
                                      type: PageTransitionType.scale,
                                      alignment: const Alignment(-0.01, -0.70),
                                      duration: const Duration(milliseconds: 500),
                                    ),
                                  );
                                }
                              : null,
                          //! Story
                          child: SizedBox(
                            child: storyProvider.listLocalImageStory[position] != null
                                ? Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(File(storyProvider.listLocalImageStory[position]!.path)),
                                          ),
                                          boxShadow: currentPageValue == position
                                              ? [
                                                  BoxShadow(
                                                    offset: const Offset(0, -10),
                                                    blurRadius: 30,
                                                    spreadRadius: 1,
                                                    color: Colors.black87.withOpacity(0.03),
                                                  ),
                                                  BoxShadow(
                                                    offset: const Offset(0, 100),
                                                    blurRadius: 30,
                                                    spreadRadius: 1,
                                                    color: Colors.black87.withOpacity(0.03),
                                                  )
                                                ]
                                              : [
                                                  BoxShadow(
                                                    offset: const Offset(0, -10),
                                                    blurRadius: 30,
                                                    spreadRadius: 1,
                                                    color: Colors.black87.withOpacity(0.03),
                                                  )
                                                ],
                                        ),
                                      ),
                                      //! view Story
                                      Positioned(
                                        top: 122,
                                        left: 0,
                                        child: Container(
                                          width: 67,
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(width: 11, height: 11, child: SvgPicture.asset('assets/svg/view.svg', color: Colors.white)),
                                              const SizedBox(width: 3),
                                              Consumer<StoryDataProvider>(builder: (context, data, child) {
                                                return Text(
                                                  data.viewStory[position].toString(),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13.8,
                                                    color: Colors.white,
                                                    shadows: [
                                                      Shadow(
                                                        color: Colors.grey,
                                                        blurRadius: 10,
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      image: storyProvider.listLocalImageStory[position] != null
                                          ? DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(File(storyProvider.listLocalImageStory[position]!.path)),
                                            )
                                          : null,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          //! List view Overview & UserView
          Expanded(
            child: PageView.builder(
              onPageChanged: (value) {
                pageController1.animateToPage(
                  value,
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.linear,
                );
              },
              physics: const BouncingScrollPhysics(),
              itemCount: storyNumber.number + 1,
              controller: pageController2,
              itemBuilder: (context, index) {
                if (index == storyNumber.number) {
                  return Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              margin: const EdgeInsets.only(top: 30),
                              decoration: BoxDecoration(
                                color: Colors.amberAccent,
                                shape: BoxShape.circle,
                                image: avatar.profileImage == null ? null : DecorationImage(fit: BoxFit.cover, image: FileImage(File(avatar.profileImage!.path))),
                              ),
                            ),
                            Positioned(
                              top: 88,
                              left: 58,
                              child: Container(
                                width: 23,
                                height: 23,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                                child: const Icon(Icons.add, color: Colors.white, size: 15),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text('Add to your story', style: TextStyle(fontSize: 23)),
                        const SizedBox(height: 20),
                        const Text('Open camera', style: TextStyle(fontSize: 15, color: Colors.blue)),
                      ],
                    ),
                  );
                }
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: 0,
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
                    DetailStory(dataIndex: index),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DetailStory extends StatefulWidget {
  final int dataIndex;
  const DetailStory({super.key, required this.dataIndex});

  @override
  State<DetailStory> createState() => _DetailStoryState();
}

class _DetailStoryState extends State<DetailStory> {
  final Color tabBarColor = const Color(0xff3897f0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final data = Provider.of<StoryDataProvider>(context);
    final dataProvider = Provider.of<DataProvider>(context);

    final formatter = NumberFormat('#,###');
    String view;
    if (data.viewStory[widget.dataIndex] < 10000) {
      view = formatter.format(data.viewStory[widget.dataIndex]);
    } else {
      view = NumberFormat.compact().format(data.viewStory[widget.dataIndex]).replaceAll('k', 'K');
    }

    return DefaultTabController(
      length: 2,
      initialIndex: dataProvider.indexTabBar,
      child: Column(
        children: [
          Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.grey.shade200, offset: Offset.zero, blurRadius: 20, spreadRadius: 3),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 45),
                  child: Divider(color: Colors.grey.shade400),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 150,

                      //! Tab Bar
                      child: TabBar(
                        labelColor: tabBarColor,
                        indicatorColor: tabBarColor,
                        dragStartBehavior: DragStartBehavior.down,
                        onTap: (int index) async {
                          final prefs = await SharedPreferences.getInstance();
                          setState(() {
                            dataProvider.indexTabBar = index;
                          });
                        },
                        indicatorWeight: 1.5,
                        labelPadding: const EdgeInsets.only(left: 5),
                        tabs: [
                          SizedBox(
                            width: 100,
                            child: Tab(
                              icon: SizedBox(
                                width: 40,
                                height: 40,
                                child: RotatedBox(
                                  quarterTurns: 0,
                                  child: SvgPicture.asset(
                                    'assets/svg/line.svg',
                                    color: dataProvider.indexTabBar == 0 ? tabBarColor : null,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: Tab(
                              icon: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      width: 11,
                                      height: 11,
                                      child: SvgPicture.asset(
                                        'assets/svg/view.svg',
                                        color: dataProvider.indexTabBar == 1 ? tabBarColor : null,
                                      )),
                                  const SizedBox(width: 4),
                                  Text(view, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: dataProvider.indexTabBar == 1 ? tabBarColor : Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: 25, height: 25, child: SvgPicture.asset('assets/svg/download.svg')),
                        const SizedBox(width: 20),
                        SizedBox(width: 24, height: 24, child: SvgPicture.asset('assets/image/upload1.svg')),
                        const SizedBox(width: 20),
                        SizedBox(width: 24, height: 24, child: SvgPicture.asset('assets/image/trash.svg')),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                OverView(dataIndex: widget.dataIndex),
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
