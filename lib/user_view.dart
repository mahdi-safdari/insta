import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/providers/csv/get_csv.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  late List<String> images;
  List<List<dynamic>> myList = [];
  @override
  void initState() {
    final List<String> images1 = List.generate(99, (index) => 'https://randomuser.me/api/portraits/${RandomImage.gender[Random().nextInt(2)]}/$index.jpg');
    final List<String> images2 = List.generate(99, (index) => 'https://picsum.photos/id/${Random().nextInt(1080)}/1080/1080');
    images = [...images1, ...images2];
    images.shuffle(Random());
    super.initState();
    MyClass().readCSV().then((data) {
      setState(() {
        myList = data;
        myList.shuffle(Random());
        print('=========>>>>>  ${data.length}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: myList.length,
        // itemCount: 100,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: ListTile(
                    leading: Stack(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.4),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: SizedBox(height: 22, width: 22, child: SvgPicture.asset('assets/image/trending-up.svg')),
                        ),
                      ],
                    ),
                    title: const Text(
                      'Boost this story',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 15,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16, top: 10),
                  child: Text(
                    'Viewers',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            );
          }
          return Padding(
            padding: const EdgeInsets.only(left: 16, top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 16),
                    //   child: Container(width: 50, height: 50, color: Colors.amber),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: CachedNetworkImage(
                        // imageUrl: 'https://randomuser.me/api/portraits/${RandomImage.gender[Random().nextInt(2)]}/${Random().nextInt(100)}.jpg',
                        imageUrl: 'https://randomuser.me/api/portraits/${RandomImage.gender[Random().nextInt(2)]}/${Random().nextInt(100)}.jpg',
                        errorWidget: (context, url, error) {
                          return Container(
                            width: 50,
                            height: 50,
                          );
                        },
                        placeholder: (context, url) {
                          return Container(
                            width: 50,
                            height: 50,
                          );
                        },
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: imageProvider,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    //! names
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          myList[index][0],
                          // RandomUserName.usernames[Random().nextInt(90)],
                          style: const TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(
                          width: 205,
                          child: Text(
                            myList[index][1],
                            // RandomUserName.names[Random().nextInt(90)],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    children: [
                      const Icon(Icons.more_vert_rounded),
                      const SizedBox(width: 25),
                      SizedBox(height: 22, width: 22, child: SvgPicture.asset('assets/svg/send.svg')),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class RandomImage {
  static const List<String> gender = ['men', 'women'];
}

class RandomUserName {
  static const List<String> usernames = ["bluesky", "jazzman", "sunsetlover", "greeneyes", "rockstar", "beachbum", "happycamper", "pizzalover", "coffeeaddict", "bookworm", "gardener", "fitnessfan", "doglover", "catperson", "artist", "writer", "baker", "cheflife", "yogagirl", "surfergirl", "skaterboy", "snowboarder", "partyanimal", "sunflower", "butterfly", "dragonfly", "firefly", "thunderstorm", "rainydays", "sunnydayz", "moonchild", "stargazer", "nightowl", "earlybird", "citylights", "countrygirl", "islandlife", "mountaingirl", "roadtripper", "travelbug", "wanderlust", "adventureseeker", "freedomfighter", "changemaker", "activist", "feminist", "goddess", "warrior", "queenbee", "kingoftheworld", "bossbabe", "entrepreneur", "startuplife", "techie", "nerdalert", "geekgirl", "gamergirl", "booknerd", "movielover", "musicaddict", "popculture", "hipster", "trendsetter", "fashionista", "makeupjunkie", "beautyqueen", "fitnessmodel", "healthyliving", "organicfoodie", "plantbased", "veganlife", "spiritualgangster", "meditation", "mindfulness", "positivevibes", "goodenergy", "kindnessmatters", "gratitudeattitude", "lovelanguages", "relationshipgoals", "familytime", "momlife", "dadsofinstagram", "petsofinstagram", "friendsforever", "bffs", "squadgoals", "teamwork", "nevergiveup", "believeinyourself", "dreambig", "hustlehard", "workinprogress"];
  static const List<String> names = ["Oliver", "Emma", "Liam", "Ava", "Noah", "Sophia", "Ethan", "Isabella", "Lucas", "Mia", "Mason", "Charlotte", "Jacob", "Amelia", "Michael", "Harper", "Benjamin", "Evelyn", "William", "Abigail", "Daniel", "Emily", "Matthew", "Elizabeth", "Joseph", "Sofia", "David", "Madison", "Aiden", "Chloe", "James", "Ella", "Elijah", "Grace", "Samuel", "Victoria", "Alexander", "Scarlett", "Isaac", "Avery", "Joshua", "Lily", "Connor", "Hannah", "Eli", "Natalie", "Levi", "Addison", "Nathan", "Aria", "Caleb", "Zoe", "Hunter", "Penelope", "Christian", "Riley", "Grayson", "Savannah", "Sebastian", "Audrey", "Gabriel", "Ellie", "Owen", "Violet", "Luke", "Stella", "Cameron", "Brooklyn", "Landon", "Claire", "Adrian", "Aaliyah", "Logan", "Skylar", "Evelyn", "Bella", "Lincoln", "Lucy", "Nicholas", "Paisley", "Jaxon", "Mila", "Asher", "Genesis", "Hudson", "Naomi", "Jeremiah", "Aurora", "Mateo", "Liliana", "Easton", "Melanie", "Ryan", "Valentina", "Nolan", "Delilah", "Colton", "Isabelle"];
}
