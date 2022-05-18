import 'dart:math';

import 'package:flutter/material.dart';

import '../../models/course_model.dart';
import '../../models/course_module_model.dart';
import '../../themes/theme.dart';

class ModuleScreen extends StatelessWidget {
  const ModuleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final map = args as Map<String, dynamic>;
    final CourseModuleModel module = map['module'] as CourseModuleModel;
    final CourseModel course = map['course'] as CourseModel;

    AppBar _appBar() {
      PreferredSize _bottom() {
        return PreferredSize(
          preferredSize: const Size(double.infinity, 1),
          child: LinearProgressIndicator(
            value: Random().nextDouble(),
            color: kPrimary,
            backgroundColor: kSecondaryText.withOpacity(.2),
          ),
        );
      }

      return AppBar(
        title: Text(module.name),
        centerTitle: true,
        bottom: _bottom(),
      );
    }

    return Scaffold(
      appBar: _appBar(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Curso: ${course.name}'),
            Text('Módulo: ${module.name}'),
            const Text('Lições concluídas: 0'),
            const Text('Lições totais: 0'),
          ],
        ),
      ),
    );
  }
}
