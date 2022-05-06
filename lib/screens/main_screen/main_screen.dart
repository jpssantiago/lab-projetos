import 'package:flutter/material.dart';

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
      Container(color: Colors.white),
      Container(color: Colors.grey),
    ];

    BottomNavigationBar _bottomNavigationBar() {
      return BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        currentIndex: currentIndex,
        onTap: setCurrentIndex,
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Lab. Projetos')),
      body: _screens[currentIndex],
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }
}
