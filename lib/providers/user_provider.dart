import 'package:flutter/material.dart';

import '../models/course_model.dart';

class UserProvider with ChangeNotifier {
  CourseModel? _selectedCourse;

  CourseModel? get selectedCourse => _selectedCourse;

  Future<void> loadUser(List<CourseModel> courses) async {
    _selectedCourse = courses[2];

    notifyListeners();
  }
}
