import 'package:flutter/material.dart';

import '../home_screen/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  void setCurrentIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      const HomeScreen(),
      Container(color: Colors.grey),
      Container(color: Colors.grey.withOpacity(.2)),
    ];

    BottomNavigationBar _bottomNavigationBar() {
      BottomNavigationBarItem _home() {
        return const BottomNavigationBarItem(
          icon: Icon(Icons.school, size: 30),
          label: '',
        );
      }

      BottomNavigationBarItem _courses() {
        return const BottomNavigationBarItem(
          icon: Icon(Icons.bookmark, size: 30),
          label: '',
        );
      }

      BottomNavigationBarItem _profile() {
        return const BottomNavigationBarItem(
          icon: Icon(Icons.person, size: 30),
          label: '',
        );
      }

      return BottomNavigationBar(
        items: [
          _home(),
          _courses(),
          _profile(),
        ],
        currentIndex: currentIndex,
        onTap: setCurrentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      );
    }

    return Scaffold(
      body: _screens[currentIndex],
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }
}
