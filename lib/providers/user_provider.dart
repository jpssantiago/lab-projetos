import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/course_model.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  CourseModel? _selectedCourse;
  UserModel? _user;

  CourseModel? get selectedCourse => _selectedCourse;
  UserModel? get user => _user;

  void setSelectedCourse(CourseModel course) {
    _selectedCourse = course;

    notifyListeners();
  }

  Future<void> loadUser() async {
    String id = "L8sUT5EftYM5cDSmYn4pdmrFE5z1";
    // TODO: Receber ID como parâmetro.

    final doc = await _database.collection('users').doc(id).get();
    _user = await UserModel.fromMap(id: id, map: doc.data() ?? {});

    _selectedCourse = _user?.courses.first.course;

    notifyListeners();
  }
}
