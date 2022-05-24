import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/course_model.dart';

class CourseProvider with ChangeNotifier {
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  List<CourseModel> _courses = [];

  List<CourseModel> get courses => _courses;

  Future<void> loadCourses() async {
    _courses = [];

    final collection = await _database.collection('courses').get();
    for (var doc in collection.docs) {
      final data = doc.data();
      _courses.add(CourseModel.fromMap(id: doc.id, map: data));
    }

    notifyListeners();
  }
}
