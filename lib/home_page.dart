import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/account_tab1.dart';
import 'package:instagram/account_tab2.dart';
import 'package:instagram/account_tab3.dart';
import 'package:instagram/data_Provider.dart';
import 'package:instagram/providers/avatar_provider.dart';
import 'package:instagram/story_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final ImagePicker _picker = ImagePicker();
  List<XFile> imagesHilight = [];
  getHilightImage() async {
    List<XFile> listImages = await _picker.pickMultiImage();

    // Save the image files to local storage
    final Directory tempDir = await getApplicationDocumentsDirectory();
    List<String> filePaths = [];
    for (int i = 0; i < listImages.length; i++) {
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}_${i + 1}.png';
      final File localImage = await File('${tempDir.path}/$fileName').create();
      final byteData = await listImages[i].readAsBytes();
      final bytes = byteData.buffer.asUint8List();
      await localImage.writeAsBytes(bytes);
      filePaths.add(localImage.path);
    }

    // Get the previously saved image paths from SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? savedPaths = prefs.getStringList('image_paths');

    // Combine the saved paths with the new ones and save them in SharedPreferences
    if (savedPaths != null && savedPaths.isNotEmpty) {
      savedPaths.addAll(filePaths);
      await prefs.setStringList('image_paths', savedPaths);
    } else {
      await prefs.setStringList('image_paths', filePaths);
    }
    // Set the imagesHilight variable with the stored image paths
    setState(() {
      final imagePaths = prefs.getStringList('image_paths');
      if (imagePaths != null && imagePaths.isNotEmpty) {
        imagesHilight = imagePaths.map((path) => XFile(path)).toList();
      }
    });
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      MyData.userName = prefs.getString('userName') ?? 'userName';

      // //! The images Hilight
      final imagePaths = prefs.getStringList('image_paths');
      if (imagePaths != null && imagePaths.isNotEmpty) {
        for (final imagePath in imagePaths) {
          imagesHilight.add(XFile(imagePath));
        }
      }
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final avatar = Provider.of<AvatarProvider>(context);
    final Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            children: [
              //! user name
              Text(MyData.userName ?? 'userName', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              const SizedBox(width: 7),
              SvgPicture.asset('assets/image/angle-small-down.svg'),
              Container(width: 8, height: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red)),
            ],
          ),
          actions: [
            SizedBox(width: 20, height: 20, child: Image.asset('assets/image/add.png')),
            const SizedBox(width: 20),
            SizedBox(width: 20, height: 20, child: SvgPicture.asset('assets/image/menu-burger.svg')),
            const SizedBox(width: 20),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //! Avatar
                      GestureDetector(
                        onLongPress: () {
                          avatar.getProfileImage();
                        },
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: const StoryPage(initialStoryIndex: 0),
                              type: PageTransitionType.scale,
                              alignment: const Alignment(-0.75, -0.70),
                              duration: const Duration(milliseconds: 500),
                            ),
                          );
                        },
                        child: avatar.profileImage == null || avatar.profileImage!.path.isEmpty
                            ? Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.cyan,
                                  boxShadow: [
                                    BoxShadow(color: Colors.grey.shade400, blurRadius: 1, spreadRadius: 0.5),
                                  ],
                                  border: Border.all(color: Colors.white, width: 3),
                                ),
                              )
                            : Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  image: DecorationImage(fit: BoxFit.cover, image: FileImage(File(avatar.profileImage!.path))),
                                  shape: BoxShape.circle,
                                  color: Colors.cyan,
                                  boxShadow: [
                                    BoxShadow(color: Colors.grey.shade400, blurRadius: 1, spreadRadius: 0.5),
                                  ],
                                  border: Border.all(color: Colors.white, width: 3),
                                ),
                              ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //! posts
                                Text(
                                  MyData.numberPost ?? '200',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                const Text(
                                  'Posts',
                                  style: TextStyle(color: Colors.black87),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //! Followers
                                Text(
                                  MyData.profileFollower ?? '400K',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                const Text(
                                  'Followers',
                                  style: TextStyle(color: Colors.black87),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //! Following
                                Text(
                                  MyData.profileFollowing ?? '360K',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                const Text(
                                  'Following',
                                  style: TextStyle(color: Colors.black87),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //! Name
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Text(
                    MyData.profileName ?? 'profileName',
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                //! bio
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    MyData.bio ?? 'Bio',
                    style: const TextStyle(fontSize: 14, height: 1.12),
                  ),
                ),
                //! link
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Transform.rotate(angle: 2, child: const Icon(Icons.link, size: 20, color: Color.fromARGB(255, 19, 107, 180))),
                      const Text(
                        't.me/+QJBKILONKLJNOIBJBJKGGF',
                        style: TextStyle(
                          color: Color.fromARGB(255, 19, 107, 180),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                //! pro dashboard
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 14),
                  child: Container(
                    height: size.height * 0.08,
                    decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          child: Column(
                            children: const [
                              Text(
                                'Professional dashboard',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'New tools are now available.',
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 20),
                          height: 8,
                          width: 8,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //! Buttons
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200,
                          ),
                          child: const Text(
                            'Edit profile',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 7),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200,
                          ),
                          child: const Text(
                            'Share profile',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //! Hilight
                hilight(),
                //! Tab Bar
                TabBar(
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                      icon: SizedBox(width: 20, height: 20, child: SvgPicture.asset('assets/image/grid.svg')),
                    ),
                    Tab(
                      icon: SizedBox(width: 20, height: 20, child: Image.asset('assets/image/video.png')),
                    ),
                    Tab(
                      icon: SizedBox(width: 20, height: 20, child: SvgPicture.asset('assets/image/portrait.svg')),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      const AccountTab1(),
                      AccountTab2(),
                      AccountTab3(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox hilight() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        itemCount: imagesHilight.isNotEmpty ? imagesHilight.length : 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    getHilightImage();
                  },
                  child: imagesHilight.isNotEmpty
                      ? Container(
                          width: 63,
                          height: 63,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            image: DecorationImage(fit: BoxFit.cover, image: FileImage(File(imagesHilight[index].path))),
                            shape: BoxShape.circle,
                            color: Colors.greenAccent,
                            boxShadow: [
                              BoxShadow(color: Colors.grey.shade400, blurRadius: 1, spreadRadius: 0.5),
                            ],
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        )
                      : Container(
                          width: 63,
                          height: 63,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.greenAccent,
                            boxShadow: [
                              BoxShadow(color: Colors.grey.shade400, blurRadius: 1, spreadRadius: 0.5),
                            ],
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                ),
                Text('استوری ${index + 1}', style: const TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
