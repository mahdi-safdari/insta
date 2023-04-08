import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/my_data.dart';
import 'package:instagram/get_data.dart';
import 'package:instagram/home_page.dart';
import 'package:instagram/providers/avatar_provider.dart';
import 'package:provider/provider.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 2;
  MyData data = MyData();
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home page'),
    Text('Search'),
    GetData(),
    Text('Reel'),
    HomePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final avatar = Provider.of<AvatarProvider>(context);

    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            activeIcon: SizedBox(width: 20, height: 20, child: SvgPicture.asset('assets/svg/home_dark.svg')),
            icon: SizedBox(width: 20, height: 20, child: SvgPicture.asset('assets/svg/home.svg')),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: SizedBox(width: 20, height: 20, child: SvgPicture.asset('assets/svg/search_dark.svg')),
            icon: SizedBox(width: 20, height: 20, child: SvgPicture.asset('assets/svg/search.svg')),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(width: 20, height: 20, child: SvgPicture.asset('assets/svg/add.svg')),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: SizedBox(width: 20, height: 20, child: SvgPicture.asset('assets/svg/reel_dark.svg')),
            icon: SizedBox(width: 24, height: 24, child: SvgPicture.asset('assets/svg/reel.svg')),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: avatar.profileImage == null || avatar.profileImage!.path.isEmpty
                ? Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.cyan,
                      boxShadow: [
                        BoxShadow(color: Colors.grey.shade400, blurRadius: 1, spreadRadius: 0.5),
                      ],
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  )
                : Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      image: DecorationImage(fit: BoxFit.cover, image: FileImage(File(avatar.profileImage!.path))),
                      shape: BoxShape.circle,
                      color: Colors.cyan,
                      boxShadow: [
                        BoxShadow(color: Colors.grey.shade400, blurRadius: 1, spreadRadius: 0.5),
                      ],
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
