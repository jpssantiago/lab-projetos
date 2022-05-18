import 'dart:math';

import 'course_model.dart';
import 'course_module_model.dart';
import 'user_course_progress.dart';

class UserModel {
  String id;
  String name;
  List<UserCourseProgress> progress;

  UserModel({
    required this.id,
    required this.name,
    required this.progress,
  });

  bool hasStartedCourse(CourseModel course) {
    for (UserCourseProgress c in progress) {
      if (c.course.id == course.id) {
        return true;
      }
    }

    return false;
  }

  double getCourseProgress(CourseModel course) {
    if (hasStartedCourse(course)) {
      return Random().nextDouble() * 100;
    }

    return 0;
  }

  double getModuleProgress(CourseModel course, CourseModuleModel module) {
    if (hasStartedCourse(course)) {
      return Random().nextDouble();
    }

    return 0;
  }

  static Future<List<UserCourseProgress>> getUserCourses(
    List<dynamic> list,
  ) async {
    List<UserCourseProgress> courses = [];

    for (var map in list) {
      courses.add(
        await UserCourseProgress.fromMap(map),
      );
    }

    return courses;
  }

  static Future<UserModel> fromMap({
    required String id,
    required Map<String, dynamic> map,
  }) async {
    return UserModel(
      id: id,
      name: map['name'],
      progress: await getUserCourses(map['progress']),
    );
  }
}
