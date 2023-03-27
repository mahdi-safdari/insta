import 'package:flutter/material.dart';
import 'package:instagram/data_provider.dart';
import 'package:instagram/get_data.dart';
import 'package:instagram/home_page.dart';
import 'package:instagram/icon/uicons.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;
  MyData data = MyData();
  static const List<Widget> _widgetOptions = <Widget>[
    Text('تنظیمات'),
    Text('سرچ'),
    GetData(),
    Text('پروفایل'),
    HomePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Uicons.fiRrHome),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Uicons.fiRrSearch),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Uicons.fiRrSquare),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Uicons.fiRrPlayAlt),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
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
