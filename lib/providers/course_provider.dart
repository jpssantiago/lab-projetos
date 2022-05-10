import 'package:flutter/material.dart';

import '../models/course_model.dart';

class CourseProvider with ChangeNotifier {
  List<CourseModel> _courses = [];

  List<CourseModel> get courses => _courses;

  Future<void> loadCourses() async {
    _courses = [];
  }
}
