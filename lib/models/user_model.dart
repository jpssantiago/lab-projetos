import 'package:app/models/course_model.dart';

import './user_course_model.dart';

class UserModel {
  String id;
  String name;
  List<UserCourseModel> courses;

  UserModel({
    required this.id,
    required this.name,
    required this.courses,
  });

  double getCourseProgress(CourseModel course) {
    for (UserCourseModel courseProgress in courses) {
      if (courseProgress.course.id == course.id) {
        int completedModules = courseProgress.completedModules.length;
        int totalModules = course.modules.length;

        return (completedModules * 100) / totalModules;
      }
    }

    return 0;
  }

  static Future<List<UserCourseModel>> getUserCourses(
    List<dynamic> list,
  ) async {
    List<UserCourseModel> courses = [];

    for (var map in list) {
      courses.add(
        await UserCourseModel.fromMap(map),
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
      courses: await getUserCourses(map['courses']),
    );
  }
}
