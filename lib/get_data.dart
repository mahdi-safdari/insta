import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/data_Provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetData extends StatefulWidget {
  const GetData({super.key});

  @override
  State<GetData> createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController profileNameController = TextEditingController();
  TextEditingController numberPostController = TextEditingController();
  TextEditingController profileFollowerController = TextEditingController();
  TextEditingController profileFollowingController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController viewController = TextEditingController();
  TextEditingController reachController = TextEditingController();
  TextEditingController engagedController = TextEditingController();
  TextEditingController profileActivityController = TextEditingController();
  TextEditingController followerController = TextEditingController();
  TextEditingController nonFollowerController = TextEditingController();
  TextEditingController impressionController = TextEditingController();
  TextEditingController intractionController = TextEditingController();
  TextEditingController sharesController = TextEditingController();
  TextEditingController forwardController = TextEditingController();
  TextEditingController navigationController = TextEditingController();
  TextEditingController repliesController = TextEditingController();
  TextEditingController exitedController = TextEditingController();
  TextEditingController nextStoryController = TextEditingController();
  TextEditingController backController = TextEditingController();
  TextEditingController profileVisitController = TextEditingController();
  TextEditingController followsController = TextEditingController();
  TextEditingController storyCountController = TextEditingController();

  Future<void> saveData({String? key, String? value, int? count}) async {
    final prefs = await SharedPreferences.getInstance();
    if (value != null) {
      prefs.setString(key!, value);
    }
    if (count != null) {
      prefs.setInt(key!, count);
    }
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      MyData.userName = prefs.getString('userName') ?? 'userName';
      MyData.profileName = prefs.getString('profileName') ?? 'profileName';
      MyData.numberPost = prefs.getString('numberPost') ?? '99';
      MyData.profileFollower = prefs.getString('profileFollower') ?? '999';
      MyData.profileFollowing = prefs.getString('profileFollowing') ?? '9K';
      MyData.bio = prefs.getString('bio') ?? 'Bio';
      MyData.view = prefs.getString('view') ?? '9K';
      MyData.reach = prefs.getString('reach') ?? '200';
      MyData.engaged = prefs.getString('engaged') ?? '--';
      MyData.profileActivity = prefs.getString('profileActivity') ?? '0';
      // MyData.follower = prefs.getString('profileActivity') ?? '0';
      // MyData.nonFollower = prefs.getString('profileActivity') ?? '0';
      MyData.impression = prefs.getString('impression') ?? '9';
      MyData.intraction = prefs.getString('intraction') ?? '19';
      MyData.shares = prefs.getString('shares') ?? '36';
      MyData.replies = prefs.getString('replies') ?? '20';
      MyData.navigation = prefs.getString('navigation') ?? '100';
      MyData.forward = prefs.getString('forward') ?? '360';
      MyData.exited = prefs.getString('exited') ?? '6';
      MyData.nextStory = prefs.getString('nextStory') ?? '33';
      MyData.back = prefs.getString('back') ?? '2';
      MyData.profileVisit = prefs.getString('profileVisit') ?? '19';
      MyData.follows = prefs.getString('profileActivity') ?? '39';
      MyData.storyCount = prefs.getInt('storyCount') ?? 10;
    });
  }

  //! --------------------------------------------------------------------------------------
  Future<void> saveDataStory({required int index, required String imagePath}) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'image_story_$index';
    prefs.setString(key, imagePath);
  }

  final List<File?> listLocalImageStory = List.generate(1000, (_) => null);
  final ImagePicker _picker = ImagePicker();
  getImageStory(int index) async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    final Directory tempDir = await getApplicationDocumentsDirectory();

    if (image != null && index >= 0) {
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}_${index * pi}.png';
      final File localImage = await File('${tempDir.path}/$fileName').create();
      final byteData = await image.readAsBytes();
      final bytes = byteData.buffer.asUint8List();
      await localImage.writeAsBytes(bytes);

      setState(() {
        listLocalImageStory[index] = localImage;
        saveDataStory(index: index, imagePath: localImage.path);
      });
    }
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

  //! --------------------------------------------------------------------------------------
  @override
  void initState() {
    getData();
    getDataStory();
    super.initState();
  }

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 150,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (String? value) {
                              if (value!.isEmpty || value == null) {
                                return 'باید یک عدد وارد کنی';
                              }
                              return null;
                            },
                            controller: storyCountController,
                            decoration: InputDecoration(
                              counterText: MyData.storyCount.toString(),
                              hintText: 'تعداد استوری',
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_globalKey.currentState!.validate()) {
                              setState(() {
                                if (MyData.storyCount != null && storyCountController.text.isNotEmpty) {
                                  MyData.storyCount = int.parse(storyCountController.text);
                                }
                                saveData(key: 'storyCount', count: int.parse(storyCountController.text));
                              });
                            }
                          },
                          child: const Text('بساز'),
                        ),
                      ],
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: SizedBox(
                        height: 200,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: MyData.storyCount ?? 1,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                getImageStory(index);
                              },
                              child: Container(
                                width: 100,
                                margin: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  image: listLocalImageStory[index] != null
                                      ? DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(File(listLocalImageStory[index]!.path)),
                                        )
                                      : null,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 380,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        textField(
                          width: 150,
                          controller: userNameController,
                          counterText: MyData.userName,
                          hintText: 'user name',
                          onChanged: (String text) {
                            setState(() {
                              MyData.userName = text;
                              saveData(key: 'userName', value: text);
                            });
                          },
                        ),
                        textField(
                          width: 150,
                          controller: profileNameController,
                          counterText: MyData.profileName,
                          hintText: 'profile Name',
                          onChanged: (String text) {
                            setState(() {
                              MyData.profileName = text;
                              saveData(key: 'profileName', value: text);
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        textField(
                          width: 150,
                          controller: numberPostController,
                          counterText: MyData.numberPost,
                          hintText: 'number Post',
                          onChanged: (String text) {
                            setState(() {
                              MyData.numberPost = text;
                              saveData(key: 'numberPost', value: text);
                            });
                          },
                        ),
                        textField(
                          width: 150,
                          controller: profileFollowerController,
                          counterText: MyData.profileFollower,
                          hintText: 'profile Follower',
                          onChanged: (String text) {
                            setState(() {
                              MyData.profileFollower = text;
                              saveData(key: 'profileFollower', value: text);
                            });
                          },
                        ),
                      ],
                    ),
                    textField(
                      width: 150,
                      controller: profileFollowingController,
                      counterText: MyData.profileFollowing,
                      hintText: 'profile Following',
                      onChanged: (String text) {
                        setState(() {
                          MyData.profileFollowing = text;
                          saveData(key: 'profileFollowing', value: text);
                        });
                      },
                    ),
                    textField(
                      width: 300,
                      controller: bioController,
                      counterText: MyData.bio,
                      hintText: 'Bio',
                      onChanged: (String text) {
                        setState(() {
                          MyData.bio = text;
                          saveData(key: 'bio', value: text);
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: 700,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        textField(
                          width: 150,
                          controller: viewController,
                          counterText: MyData.view,
                          hintText: 'view story',
                          onChanged: (String text) {
                            setState(() {
                              MyData.view = text;
                              saveData(key: 'view', value: text);
                            });
                          },
                        ),
                        textField(
                          width: 150,
                          controller: reachController,
                          counterText: MyData.reach,
                          hintText: 'Account reach',
                          onChanged: (String text) {
                            setState(() {
                              MyData.reach = text;
                              saveData(key: 'reach', value: text);
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        textField(
                          width: 150,
                          controller: engagedController,
                          counterText: MyData.engaged,
                          hintText: 'Account engaged',
                          onChanged: (String text) {
                            setState(() {
                              MyData.engaged = text;
                              saveData(key: 'engaged', value: text);
                            });
                          },
                        ),
                        textField(
                          width: 150,
                          controller: profileActivityController,
                          counterText: MyData.profileActivity,
                          hintText: 'profile Activity',
                          onChanged: (String text) {
                            setState(() {
                              MyData.profileActivity = text;
                              saveData(key: 'profileActivity', value: text);
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        textField(
                          width: 150,
                          controller: impressionController,
                          counterText: MyData.impression,
                          hintText: 'impression',
                          onChanged: (String text) {
                            setState(() {
                              MyData.impression = text;
                              saveData(key: 'impression', value: text);
                            });
                          },
                        ),
                        textField(
                          width: 150,
                          controller: intractionController,
                          counterText: MyData.intraction,
                          hintText: 'intraction',
                          onChanged: (String text) {
                            setState(() {
                              MyData.intraction = text;
                              saveData(key: 'intraction', value: text);
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        textField(
                          width: 150,
                          controller: sharesController,
                          counterText: MyData.shares,
                          hintText: 'shares',
                          onChanged: (String text) {
                            setState(() {
                              MyData.shares = text;
                              saveData(key: 'shares', value: text);
                            });
                          },
                        ),
                        textField(
                          width: 150,
                          controller: repliesController,
                          counterText: MyData.replies,
                          hintText: 'replies',
                          onChanged: (String text) {
                            setState(() {
                              MyData.replies = text;
                              saveData(key: 'replies', value: text);
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        textField(
                          width: 150,
                          controller: navigationController,
                          counterText: MyData.navigation,
                          hintText: 'navigation',
                          onChanged: (String text) {
                            setState(() {
                              MyData.navigation = text;
                              saveData(key: 'navigation', value: text);
                            });
                          },
                        ),
                        textField(
                          width: 150,
                          controller: forwardController,
                          counterText: MyData.forward,
                          hintText: 'forward',
                          onChanged: (String text) {
                            setState(() {
                              MyData.forward = text;
                              saveData(key: 'forward', value: text);
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        textField(
                          width: 150,
                          controller: exitedController,
                          counterText: MyData.exited,
                          hintText: 'exited',
                          onChanged: (String text) {
                            setState(() {
                              MyData.exited = text;
                              saveData(key: 'exited', value: text);
                            });
                          },
                        ),
                        textField(
                          width: 150,
                          controller: nextStoryController,
                          counterText: MyData.nextStory,
                          hintText: 'nextStory',
                          onChanged: (String text) {
                            setState(() {
                              MyData.nextStory = text;
                              saveData(key: 'nextStory', value: text);
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        textField(
                          width: 150,
                          controller: backController,
                          counterText: MyData.back,
                          hintText: 'back',
                          onChanged: (String text) {
                            setState(() {
                              MyData.back = text;
                              saveData(key: 'back', value: text);
                            });
                          },
                        ),
                        textField(
                          width: 150,
                          controller: profileVisitController,
                          counterText: MyData.profileVisit,
                          hintText: 'profileVisit',
                          onChanged: (String text) {
                            setState(() {
                              MyData.profileVisit = text;
                              saveData(key: 'profileVisit', value: text);
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        textField(
                          width: 150,
                          controller: followsController,
                          counterText: MyData.follows,
                          hintText: 'follows',
                          onChanged: (String text) {
                            setState(() {
                              MyData.follows = text;
                              saveData(key: 'follows', value: text);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField({
    required TextEditingController? controller,
    required String? counterText,
    required String? hintText,
    required Function(String)? onChanged,
    required double? width,
  }) {
    return SizedBox(
      width: width,
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          counterText: counterText,
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
