import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/course_model.dart';
import '../models/course_module_model.dart';

class CourseProvider with ChangeNotifier {
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  List<CourseModel> _courses = [];

  List<CourseModel> get courses => _courses;

  CourseModel? getCourseByModule(CourseModuleModel module) {
    for (CourseModel course in _courses) {
      for (CourseModuleModel m in course.modules) {
        if (m.id == module.id) {
          return course;
        }
      }
    }

    return null;
  }

  Future<void> loadCourses() async {
    _courses = [];

    final collection = await _database.collection('courses').get();
    for (var doc in collection.docs) {
      final data = doc.data();
      _courses.add(CourseModel.fromMap(
        id: doc.id,
        map: data,
        ref: doc.reference,
      ));
    }

    notifyListeners();
  }
}
