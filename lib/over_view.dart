import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/my_data.dart';
import 'package:instagram/providers/data_provider.dart';
import 'package:instagram/providers/slider_provider.dart';
import 'package:instagram/providers/story_data_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OverView extends StatefulWidget {
  final int dataIndex;
  const OverView({super.key, required this.dataIndex});

  @override
  State<OverView> createState() => _OverViewState();
}

class _OverViewState extends State<OverView> {
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
    });
  }

  late List<_ChartData> data;
  late TooltipBehavior _tooltip;
  bool _isLoading = true;
  @override
  void initState() {
    getData();
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final slider = Provider.of<SliderProvider>(context);
    final dataProvider = Provider.of<DataProvider>(context);
    final dataStory = Provider.of<StoryDataProvider>(context);
    var n = slider.follower - slider.nonFollower;
    var space = n / pi * 0.08;

    data = [
      _ChartData('A', space.toDouble()),
      _ChartData('Steve', slider.nonFollower.toDouble()),
      _ChartData('B', space.toDouble()),
      _ChartData('David', slider.follower.toDouble()),
    ];
    _tooltip = TooltipBehavior(enable: true);
    final formatter = NumberFormat('#,###');
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

    return SingleChildScrollView(
      child: Column(
        children: [
          //! Over View
          Container(
            padding: const EdgeInsets.only(top: 10),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Overview',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SvgPicture.asset('assets/svg/ThreadDetails.svg', width: 18, height: 18),
                    ],
                  ),
                  const SizedBox(height: 25),
                  TextAndNumber(text: 'Accounts reached', number: formatter.format(dataStory.reach[widget.dataIndex])),
                  const SizedBox(height: 25),
                  TextAndNumber(text: 'Accounts engaged', number: formatter.format(dataStory.engaged[widget.dataIndex])),
                  const SizedBox(height: 25),
                  TextAndNumber(text: 'Profile activity', number: formatter.format(dataStory.profileVisit[widget.dataIndex] + dataStory.follows[widget.dataIndex])),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          //! Reach
          Container(
            color: Colors.white,
            height: 400,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: Row(
                      children: [
                        const Text(
                          'Reach',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        SvgPicture.asset('assets/svg/ThreadDetails.svg', width: 18, height: 18),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 45),
                    child: Column(
                      children: [
                        Text(
                          formatter.format(dataStory.reach[widget.dataIndex]),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Accounts reached',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  //! Slider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //! Follower chart
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            formatter.format(dataStory.followerChart[widget.dataIndex]),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              const Text(
                                'Followers',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      //! slider
                      SizedBox(
                        width: 90,
                        height: 90,
                        child: SfCircularChart(
                          tooltipBehavior: _tooltip,
                          series: <CircularSeries<_ChartData, String>>[
                            DoughnutSeries<_ChartData, String>(
                              animationDelay: 0,
                              animationDuration: 0,
                              strokeWidth: 10,
                              pointColorMapper: (_ChartData datum, int index) {
                                if (index == 1) {
                                  return Colors.blue[900];
                                } else if (index == 3) {
                                  return Colors.blue;
                                }
                                return Colors.white;
                              },
                              dataSource: data,
                              xValueMapper: (_ChartData data, _) => data.x,
                              yValueMapper: (_ChartData data, _) => data.y,
                              innerRadius: '37',
                            ),
                          ],
                        ),
                      ),
                      //! non Follower chart
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formatter.format(dataStory.nonFollowerChart[widget.dataIndex]),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue[900],
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                'Non-followers',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  const Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Divider(),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Impression',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(
                          formatter.format(dataStory.impression[widget.dataIndex]),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          //! Engagement
          Container(
            color: Colors.white,
            // height: 800,
            child: Column(
              children: [
                //! Engagement
                Padding(
                  padding: const EdgeInsets.only(top: 35, left: 16),
                  child: Row(
                    children: [
                      const Text(
                        'Engagement',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SvgPicture.asset('assets/svg/ThreadDetails.svg', width: 18, height: 18),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 45),
                      child: Column(
                        children: [
                          Text(
                            formatter.format(dataStory.engaged[widget.dataIndex]),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Accounts engaged',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Divider(),
                    ),
                  ],
                ),
                //! Story intractions
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Story intractions',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(
                          formatter.format(dataStory.share[widget.dataIndex] + dataStory.replies[widget.dataIndex]),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                //! Shares
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 30),
                  child: TextAndNumber(text: 'Shares', number: formatter.format(dataStory.share[widget.dataIndex])),
                ),
                //! Replies
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 30),
                  child: TextAndNumber(text: 'Replies', number: formatter.format(dataStory.replies[widget.dataIndex])),
                ),
                //! Divider
                Visibility(
                  visible: dataStory.link[widget.dataIndex] != 0,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Divider(),
                  ),
                ),
                //! Link Clicks
                Visibility(
                  visible: dataStory.link[widget.dataIndex] != 0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextAndNumber(text: 'Link Clicks', number: formatter.format(dataStory.link[widget.dataIndex])),
                  ),
                ),
                //! Divider
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Divider(),
                ),

                //! Sticker taps
                Visibility(
                  visible: dataStory.stickerTap[widget.dataIndex] != 0,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Sticker taps',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Text(
                                formatter.format(dataStory.stickerTap[widget.dataIndex]),
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //! tag 1
                      Visibility(
                        visible: dataStory.tap1[widget.dataIndex] != 0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 30),
                          child: TextAndNumber(
                            text: '@${dataStory.nameTap1[widget.dataIndex]}',
                            number: formatter.format(dataStory.tap1[widget.dataIndex]),
                          ),
                        ),
                      ),
                      //! tag 2
                      Visibility(
                        visible: dataStory.tap2[widget.dataIndex] != 0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 30),
                          child: TextAndNumber(
                            text: '@${dataStory.nameTap2[widget.dataIndex]}',
                            number: formatter.format(dataStory.tap2[widget.dataIndex]),
                          ),
                        ),
                      ),
                      //! tag 3
                      Visibility(
                        visible: dataStory.tap3[widget.dataIndex] != 0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 30),
                          child: TextAndNumber(
                            text: '@${dataStory.nameTap3[widget.dataIndex]}',
                            number: formatter.format(dataStory.tap3[widget.dataIndex]),
                          ),
                        ),
                      ),
                      //! Divider
                      const Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Divider(),
                      ),
                    ],
                  ),
                ),

                //! Navigation
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Navigation',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(
                          formatter.format(dataStory.forward[widget.dataIndex] + dataStory.exited[widget.dataIndex] + dataStory.nextStory[widget.dataIndex] + dataStory.back[widget.dataIndex]),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                //! Forward
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 30),
                  child: TextAndNumber(text: 'Forward', number: formatter.format(dataStory.forward[widget.dataIndex])),
                ),
                //! Exited
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 30),
                  child: TextAndNumber(text: 'Exited', number: formatter.format(dataStory.exited[widget.dataIndex])),
                ),
                //! Next Story
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 30),
                  child: TextAndNumber(text: 'Next story', number: formatter.format(dataStory.nextStory[widget.dataIndex])),
                ),
                //! Back
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 30, bottom: 20),
                  child: TextAndNumber(text: 'Back', number: formatter.format(dataStory.back[widget.dataIndex])),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          //! Profile activity
          Container(
            height: 150,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Profile activity',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(width: 10),
                          SvgPicture.asset('assets/svg/ThreadDetails.svg', width: 18, height: 18),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Text(
                          formatter.format(dataStory.profileVisit[widget.dataIndex] + dataStory.follows[widget.dataIndex]),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextAndNumber(text: 'Profile visits', number: formatter.format(dataStory.profileVisit[widget.dataIndex])),
                  TextAndNumber(text: 'Follows', number: formatter.format(dataStory.follows[widget.dataIndex])),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextAndNumber extends StatelessWidget {
  final String? text;
  final String? number;
  const TextAndNumber({super.key, this.text, this.number});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text!),
          Text(number!),
        ],
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
