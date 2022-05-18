import 'package:flutter/material.dart';

import 'lesson_model.dart';

class CourseModuleModel {
  String name;
  IconData icon;
  List<LessonModel> lessons;

  CourseModuleModel({
    required this.name,
    required this.icon,
    required this.lessons,
  });

  static List<CourseModuleModel> fromMapList(List<dynamic> list) {
    List<CourseModuleModel> modules = [];

    for (var map in list) {
      modules.add(CourseModuleModel(
        name: map['name'] ?? 'Módulo',
        icon: IconData(
          int.parse(map['icon'].toString()),
          fontFamily: 'MaterialIcons',
        ),
        lessons: LessonModel.fromMapList(map['lessons'] ?? []),
      ));
    }

    return modules;
  }
}
