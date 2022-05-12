import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/course_model.dart';

class CourseProvider with ChangeNotifier {
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  Future<List<CourseModel>> getCourses() async {
    List<CourseModel> courses = [];

    final collection = await _database.collection('courses').get();
    for (var doc in collection.docs) {
      final data = doc.data();
      courses.add(CourseModel.fromMap(id: doc.id, map: data));
    }

    return courses;
  }
}
