import 'dart:io';

import 'package:flutter/material.dart';
import 'package:instagram/my_data.dart';
import 'package:instagram/providers/data_provider.dart';
import 'package:instagram/providers/slider_provider.dart';
import 'package:instagram/providers/story_data_provider.dart';
import 'package:instagram/providers/story_images_provider.dart';
import 'package:instagram/providers/story_number_provider.dart';
import 'package:provider/provider.dart';
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
  TextEditingController gridController = TextEditingController();

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
      MyData.storyCount = prefs.getInt('storyCount') ?? 1;
    });
  }

  @override
  void initState() {
    getData();
    // getDataStory();
    super.initState();
  }

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final storyNumber = Provider.of<StoryNumberProvider>(context);
    final slider = Provider.of<SliderProvider>(context, listen: false);
    final grid = Provider.of<StoryNumberProvider>(context, listen: false);
    final dataProvider = Provider.of<DataProvider>(context);
    final storyProvider = Provider.of<StoryImagesProvider>(context);
    final data = Provider.of<StoryDataProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              //! Profile
              Container(
                padding: const EdgeInsets.all(8),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
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
                          width: 150,
                          counterText: dataProvider.linkProfile,
                          hintText: 'link profile',
                          onChanged: (String text) {
                            setState(() {
                              if (text.isNotEmpty) {
                                dataProvider.linkProfile = text;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    textField(
                      width: 300,
                      counterText: dataProvider.textProfile,
                      hintText: 'text dashboard',
                      onChanged: (String text) {
                        setState(() {
                          if (text.isNotEmpty) {
                            dataProvider.textProfile = text;
                          }
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        textField(
                          width: 150,
                          keyboardType: TextInputType.number,
                          controller: gridController,
                          counterText: grid.grid.toString(),
                          hintText: 'post number',
                          onChanged: (String text) {
                            setState(() {
                              if (text.isNotEmpty) {
                                grid.grid = int.parse(text);
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //! Story
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
                              counterText: storyNumber.number.toString(),
                              hintText: 'تعداد استوری',
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_globalKey.currentState!.validate()) {
                              setState(() {
                                storyNumber.number = int.parse(storyCountController.text);
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
                          itemCount: storyNumber.number,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                storyProvider.getImageStory(index);
                              },
                              child: Container(
                                width: 80,
                                margin: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  image: storyProvider.listLocalImageStory[index] != null
                                      ? DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(File(storyProvider.listLocalImageStory[index]!.path)),
                                        )
                                      : null,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: size.height * 2.1,
                      child: PageView.builder(
                        itemCount: storyNumber.number,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  child: Text(
                                    'Story ${index + 1}',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                                  ),
                                ),
                                //! view Story & Reach
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    textField(
                                      width: 150,
                                      keyboardType: TextInputType.number,
                                      counterText: data.viewStory[index].toString(),
                                      hintText: 'view story',
                                      onChanged: (String text) {
                                        setState(() {
                                          if (text.isNotEmpty) {
                                            data.saveViewStory(value: int.parse(text), index: index);
                                          }
                                        });
                                      },
                                    ),
                                    textField(
                                      width: 150,
                                      keyboardType: TextInputType.number,
                                      counterText: data.reach[index].toString(),
                                      hintText: 'Account reach',
                                      onChanged: (String text) {
                                        setState(() {
                                          if (text.isNotEmpty) {
                                            data.saveReach(value: int.parse(text), index: index);
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                const Divider(color: Colors.black, height: 50),
                                //! follower chart & non follower chart
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    textField(
                                      width: 150,
                                      keyboardType: TextInputType.number,
                                      counterText: data.followerChart[index].toString(),
                                      hintText: 'follower chart',
                                      onChanged: (String text) {
                                        setState(() {
                                          if (text.isNotEmpty) {
                                            data.saveFollowerChart(value: int.parse(text), index: index);
                                          }
                                        });
                                      },
                                    ),
                                    textField(
                                      width: 150,
                                      keyboardType: TextInputType.number,
                                      counterText: data.nonFollowerChart[index].toString(),
                                      hintText: 'non follower chart',
                                      onChanged: (String text) {
                                        setState(() {
                                          if (text.isNotEmpty) {
                                            data.saveNonFollowerChart(value: int.parse(text), index: index);
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),

                                const Divider(color: Colors.black, height: 50),
                                //! impression
                                textField(
                                  width: 150,
                                  keyboardType: TextInputType.number,
                                  controller: impressionController,
                                  counterText: data.impression[index].toString(),
                                  hintText: 'impression',
                                  onChanged: (String text) {
                                    setState(() {
                                      if (text.isNotEmpty) {
                                        data.saveImpression(value: int.parse(text), index: index);
                                      }
                                    });
                                  },
                                ),
                                const Divider(color: Colors.black, height: 50),
                                //! Account engaged
                                textField(
                                  width: 150,
                                  keyboardType: TextInputType.number,
                                  counterText: data.engaged[index].toString(),
                                  hintText: 'Account engaged',
                                  onChanged: (String text) {
                                    setState(() {
                                      if (text.isNotEmpty) {
                                        data.saveEngaged(value: int.parse(text), index: index);
                                      }
                                    });
                                  },
                                ),
                                const Divider(color: Colors.black, height: 50),
                                //! shares & replies
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    textField(
                                      width: 150,
                                      keyboardType: TextInputType.number,
                                      counterText: data.share[index].toString(),
                                      hintText: 'shares',
                                      onChanged: (String text) {
                                        setState(() {
                                          if (text.isNotEmpty) {
                                            data.saveShare(value: int.parse(text), index: index);
                                          }
                                        });
                                      },
                                    ),
                                    textField(
                                      width: 150,
                                      keyboardType: TextInputType.number,
                                      counterText: data.replies[index].toString(),
                                      hintText: 'replies',
                                      onChanged: (String text) {
                                        setState(() {
                                          if (text.isNotEmpty) {
                                            data.saveReplies(value: int.parse(text), index: index);
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                const Divider(color: Colors.black, height: 50),
                                //! link
                                textField(
                                  width: 150,
                                  keyboardType: TextInputType.number,
                                  counterText: data.link[index].toString(),
                                  hintText: 'Links Clicks',
                                  onChanged: (String text) {
                                    setState(() {
                                      if (text.isNotEmpty) {
                                        data.saveLink(value: int.parse(text), index: index);
                                      }
                                    });
                                  },
                                ),
                                const Divider(color: Colors.black, height: 50),
                                //! sticker tap
                                textField(
                                  width: 150,
                                  keyboardType: TextInputType.number,
                                  counterText: data.stickerTap[index].toString(),
                                  hintText: 'Sticker taps',
                                  onChanged: (String text) {
                                    setState(() {
                                      if (text.isNotEmpty) {
                                        data.saveStickerTap(value: int.parse(text), index: index);
                                      }
                                    });
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    textField(
                                      width: 150,
                                      keyboardType: TextInputType.number,
                                      counterText: data.tap1[index].toString(),
                                      hintText: 'Sticker tap 1',
                                      onChanged: (String text) {
                                        setState(() {
                                          if (text.isNotEmpty) {
                                            data.saveTap1(value: int.parse(text), index: index);
                                          }
                                        });
                                      },
                                    ),
                                    textField(
                                      width: 150,
                                      counterText: data.nameTap1[index],
                                      hintText: 'Name tap 1',
                                      onChanged: (String text) {
                                        setState(() {
                                          if (text.isNotEmpty) {
                                            data.saveNameTap1(value: text, index: index);
                                          }
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
                                      keyboardType: TextInputType.number,
                                      counterText: data.tap2[index].toString(),
                                      hintText: 'Sticker tap 2',
                                      onChanged: (String text) {
                                        setState(() {
                                          if (text.isNotEmpty) {
                                            data.saveTap2(value: int.parse(text), index: index);
                                          }
                                        });
                                      },
                                    ),
                                    textField(
                                      width: 150,
                                      counterText: data.nameTap2[index],
                                      hintText: 'Name tap 2',
                                      onChanged: (String text) {
                                        setState(() {
                                          if (text.isNotEmpty) {
                                            data.saveNameTap2(value: text, index: index);
                                          }
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
                                      keyboardType: TextInputType.number,
                                      counterText: data.tap3[index].toString(),
                                      hintText: 'Sticker tap 3',
                                      onChanged: (String text) {
                                        setState(() {
                                          if (text.isNotEmpty) {
                                            data.saveTap3(value: int.parse(text), index: index);
                                          }
                                        });
                                      },
                                    ),
                                    textField(
                                      width: 150,
                                      counterText: data.nameTap3[index],
                                      hintText: 'Name tap 3',
                                      onChanged: (String text) {
                                        setState(() {
                                          if (text.isNotEmpty) {
                                            data.saveNameTap3(value: text, index: index);
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                const Divider(color: Colors.black, height: 50),
                                //! Navigation
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    textField(
                                      width: 150,
                                      keyboardType: TextInputType.number,
                                      counterText: data.forward[index].toString(),
                                      hintText: 'forward',
                                      onChanged: (String text) {
                                        setState(() {
                                          if (text.isNotEmpty) {
                                            data.saveForward(value: int.parse(text), index: index);
                                          }
                                        });
                                      },
                                    ),
                                    textField(
                                      width: 150,
                                      keyboardType: TextInputType.number,
                                      counterText: data.exited[index].toString(),
                                      hintText: 'exited',
                                      onChanged: (String text) {
                                        setState(() {
                                          if (text.isNotEmpty) {
                                            data.saveExited(value: int.parse(text), index: index);
                                          }
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
                                      keyboardType: TextInputType.number,
                                      counterText: data.nextStory[index].toString(),
                                      hintText: 'nextStory',
                                      onChanged: (String text) {
                                        setState(() {
                                          if (text.isNotEmpty) {
                                            data.saveNextStory(value: int.parse(text), index: index);
                                          }
                                        });
                                      },
                                    ),
                                    textField(
                                      width: 150,
                                      keyboardType: TextInputType.number,
                                      counterText: data.back[index].toString(),
                                      hintText: 'back',
                                      onChanged: (String text) {
                                        setState(() {
                                          if (text.isNotEmpty) {
                                            data.saveBack(value: int.parse(text), index: index);
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                const Divider(color: Colors.black, height: 50),
                                //! profile activity
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    textField(
                                      width: 150,
                                      keyboardType: TextInputType.number,
                                      counterText: data.profileVisit[index].toString(),
                                      hintText: 'profileVisit',
                                      onChanged: (String text) {
                                        setState(() {
                                          if (text.isNotEmpty) {
                                            data.saveProfileVisit(value: int.parse(text), index: index);
                                          }
                                        });
                                      },
                                    ),
                                    textField(
                                      width: 150,
                                      keyboardType: TextInputType.number,
                                      counterText: data.follows[index].toString(),
                                      hintText: 'follows',
                                      onChanged: (String text) {
                                        setState(() {
                                          if (text.isNotEmpty) {
                                            data.saveFollows(value: int.parse(text), index: index);
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                const Divider(color: Colors.black, height: 50),

                                textField(
                                  width: 150,
                                  keyboardType: TextInputType.number,
                                  counterText: data.activity[index].toString(),
                                  hintText: 'profile Activity',
                                  onChanged: (String text) {
                                    setState(() {
                                      if (text.isNotEmpty) {
                                        data.saveActivity(value: int.parse(text), index: index);
                                      }
                                    });
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    textField(
                                      width: 150,
                                      keyboardType: TextInputType.number,
                                      counterText: data.intraction[index].toString(),
                                      hintText: 'intraction',
                                      onChanged: (String text) {
                                        setState(() {
                                          if (text.isNotEmpty) {
                                            data.saveIntraction(value: int.parse(text), index: index);
                                          }
                                        });
                                      },
                                    ),
                                    textField(
                                      width: 150,
                                      keyboardType: TextInputType.number,
                                      counterText: MyData.navigation,
                                      hintText: 'navigation',
                                      onChanged: (String text) {
                                        setState(() {
                                          if (text.isNotEmpty) {
                                            data.saveNavigation(value: int.parse(text), index: index);
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              //! ------------++++--------------++++----------
            ],
          ),
        ),
      ),
    );
  }

  Widget textField({
    TextEditingController? controller,
    required String? counterText,
    required String? hintText,
    required Function(String)? onChanged,
    required double? width,
    TextInputType? keyboardType,
  }) {
    return SizedBox(
      width: width,
      child: TextField(
        keyboardType: keyboardType,
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
