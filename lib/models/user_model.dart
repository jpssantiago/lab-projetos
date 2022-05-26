import 'dart:math';

import 'course_model.dart';
import 'course_module_model.dart';
import 'user_course_progress.dart';

class UserModel {
  String id;
  String name;
  List<UserCourseProgress> myCourses;
  String? picture;

  UserModel({
    required this.id,
    required this.name,
    required this.myCourses,
    this.picture,
  });

  void addCourseToSavedOnes(CourseModel course) {
    for (UserCourseProgress c in myCourses) {
      if (c.course.id == course.id) {
        return;
      }
    }

    myCourses.add(UserCourseProgress(
      course: course,
      completedModules: [],
    ));
  }

  void setCompletedModule(CourseModuleModel module) {
    // for (UserCourseProgress c in myCourses) {
    //   for (CourseModuleModel m in c.course.modules) {
    //     if (m.id == module.id) {
    //       c.completedModules.add(module);
    //     }
    //   }
    // }
  }

  bool hasStartedCourse(CourseModel course) {
    for (UserCourseProgress c in myCourses) {
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
    for (UserCourseProgress c in myCourses) {
      if (c.course.id == course.id) {
        for (var m in c.completedModules) {
          if (m.id == module.id) {
            return 100;
          }
        }
      }
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
      myCourses: await getUserCourses(map['my_courses']),
      picture: map['picture'],
    );
  }
}
