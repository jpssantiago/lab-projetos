import 'package:flutter/material.dart';

class CourseModuleModel {
  String name;
  IconData icon;

  CourseModuleModel({
    required this.name,
    required this.icon,
  });

  static List<CourseModuleModel> fromMapList(List<dynamic> list) {
    List<CourseModuleModel> modules = [];

    for (var map in list) {
      modules.add(CourseModuleModel(
        name: map['name'],
        icon: IconData(
          int.parse(map['icon'].toString()),
          fontFamily: 'MaterialIcons',
        ),
      ));
    }

    return modules;
  }
}
