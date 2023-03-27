import 'package:flutter/material.dart';
import 'package:instagram/data_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OverView extends StatefulWidget {
  const OverView({super.key});

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
    });
  }

  late List<_ChartData> data;
  late TooltipBehavior _tooltip;
  @override
  void initState() {
    getData();
    data = [
      _ChartData('David', 5),
      _ChartData('Steve', 38),
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    children: const [
                      Text(
                        'Overview',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.error_outline_sharp, size: 20)
                    ],
                  ),
                  const SizedBox(height: 25),
                  TextAndNumber(text: 'Accounts reached', number: MyData.reach ?? '89'),
                  const SizedBox(height: 25),
                  TextAndNumber(text: 'Accounts engaged', number: MyData.engaged ?? '--'),
                  const SizedBox(height: 25),
                  TextAndNumber(text: 'Profile activity', number: MyData.profileActivity ?? '350'),
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
                      children: const [
                        Text(
                          'Reach',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.error_outline_sharp, size: 20)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 45),
                    child: Column(
                      children: [
                        Text(
                          MyData.reach ?? '89',
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            data[1].y.toStringAsFixed(0),
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
                              strokeWidth: 10,
                              pointColorMapper: (_ChartData datum, int index) {
                                if (index == 0) {
                                  return Colors.blue[900];
                                }
                                return Colors.blue;
                              },
                              dataSource: data,
                              xValueMapper: (_ChartData data, _) => data.x,
                              yValueMapper: (_ChartData data, _) => data.y,
                              name: 'Gold',
                              innerRadius: '37',
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data[0].y.toStringAsFixed(0),
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
                          MyData.impression ?? '94',
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
            height: 600,
            child: Column(
              children: [
                //! Engagement
                Padding(
                  padding: const EdgeInsets.only(top: 35, left: 16),
                  child: Row(
                    children: const [
                      Text(
                        'Engagement',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.error_outline_sharp, size: 20)
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
                            MyData.engaged ?? '89',
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
                          MyData.intraction ?? '10',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                //! Shares
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 30),
                  child: TextAndNumber(text: 'Shares', number: MyData.shares ?? '5'),
                ),
                //! Replies
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 30),
                  child: TextAndNumber(text: 'Replies', number: MyData.replies ?? '0'),
                ),
                //! Divider
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Divider(),
                ),
                //! ---
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
                          MyData.navigation ?? '133',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                //! Forward
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 30),
                  child: TextAndNumber(text: 'Forward', number: MyData.forward ?? '107'),
                ),
                //! Exited
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 30),
                  child: TextAndNumber(text: 'Exited', number: MyData.exited ?? '15'),
                ),
                //! Next Story
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 30),
                  child: TextAndNumber(text: 'Next story', number: MyData.nextStory ?? '10'),
                ),
                //! Back
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 30),
                  child: TextAndNumber(text: 'Back', number: MyData.back ?? '1'),
                ),
              ],
            ),
          ),
          //! Profile activity
          const SizedBox(height: 8),

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
                        children: const [
                          Text(
                            'Profile activity',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.error_outline_sharp, size: 20),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Text(
                          MyData.profileActivity ?? '0',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextAndNumber(text: 'Profile visits', number: MyData.profileVisit ?? '19'),
                  TextAndNumber(text: 'Follows', number: MyData.follows ?? '100'),
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
  final String text;
  final String number;
  const TextAndNumber({super.key, required this.text, required this.number});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          Text(number),
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
