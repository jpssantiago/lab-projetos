import 'package:flutter/material.dart';

import 'package:lab_projetos/screens/main_screen/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'main': (context) => const MainScreen(),
      },
      initialRoute: 'main',
    );
  }
}
