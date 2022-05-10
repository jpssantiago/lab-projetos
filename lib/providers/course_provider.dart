import 'package:flutter/material.dart';

import '../models/course_model.dart';

class CourseProvider with ChangeNotifier {
  List<CourseModel> _courses = [];

  List<CourseModel> get courses => _courses;

  Future<void> loadCourses() async {
    await Future.delayed(const Duration(seconds: 5), () {
      _courses = [
        CourseModel(id: '0', name: 'Python'),
        CourseModel(id: '1', name: 'Javascript'),
        CourseModel(id: '2', name: 'Java'),
      ];

      notifyListeners();
    });
  }
}
