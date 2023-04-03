import 'package:flutter/material.dart';

import 'package:instagram/main_wrapper.dart';
import 'package:instagram/my_data.dart';
import 'package:instagram/providers/avatar_provider.dart';
import 'package:instagram/providers/data_provider.dart';
import 'package:instagram/providers/slider_provider.dart';
import 'package:instagram/providers/story_data_provider.dart';
import 'package:instagram/providers/story_images_provider.dart';
import 'package:instagram/providers/story_number_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<StoryNumberProvider>(create: (context) => StoryNumberProvider(prefs)..loadNumber()),
        ChangeNotifierProvider<AvatarProvider>(create: (context) => AvatarProvider(prefs)..loadAvatar()),
        ChangeNotifierProvider<SliderProvider>(create: (context) => SliderProvider(prefs)..loadSliderNumber()),
        ChangeNotifierProvider<DataProvider>(create: (context) => DataProvider(prefs)..loadDataProvider()),
        ChangeNotifierProvider<StoryImagesProvider>(create: (context) => StoryImagesProvider(prefs)..getDataStory()),
        ChangeNotifierProvider<StoryDataProvider>(create: (context) => StoryDataProvider(prefs)..getData()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      MyData.userName = prefs.getString('userName') ?? 'userName';
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Instagram',
      debugShowCheckedModeBanner: false,
      home: MainWrapper(),
    );
  }
}
