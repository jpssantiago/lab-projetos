import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/course_provider.dart';
import '../../providers/user_provider.dart';
import '../home_screen/home_screen.dart';
import '../profile_screen/profile_screen.dart';

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

  void loadData() async {
    final courseProvider = Provider.of<CourseProvider>(
      context,
      listen: false,
    );

    await courseProvider.loadCourses();

    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    await userProvider.loadUser(courseProvider.courses);
  }

  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      const HomeScreen(),
      Container(color: Colors.grey),
      const ProfileScreen(),
    ];

    BottomNavigationBar _bottomNavigationBar() {
      BottomNavigationBarItem _learn() {
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
          _learn(),
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
