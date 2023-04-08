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
  List<List<dynamic>> myList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
    MyClass().readCSV().then((data) {
      setState(() {
        myList = data;
        myList.shuffle(Random());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> images1 = List.generate(60, (index) => 'https://randomuser.me/api/portraits/${RandomImage.gender[Random().nextInt(2)]}/$index.jpg');
    final List<String> images2 = List.generate(369, (index) => 'https://picsum.photos/id/${Random().nextInt(1080)}/200/200');
    final List<String> images = [...images1, ...images2];
    images.shuffle(Random());
    //! Loading
    if (_isLoading) {
      return Container(
        color: Colors.white,
        child: Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey.shade300,
              color: Colors.grey[500],
              strokeWidth: 1,
            ),
          ),
        ),
      );
    }
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
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: CachedNetworkImage(
                        imageUrl: myList[index][2],
                        errorWidget: (context, url, error) {
                          return Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(images[index]),
                              ),
                            ),
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
                          myList[index][0].toString(),
                          style: const TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(
                          width: 205,
                          child: Text(
                            myList[index][1].toString(),
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
