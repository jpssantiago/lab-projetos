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

  bool alreadyStatedCourse(CourseModel course) {
    for (UserCourseProgress c in myCourses) {
      if (c.course.id == course.id) {
        return true;
      }
    }

    return false;
  }

  bool alreadyCompletedModule(CourseModel course, CourseModuleModel module) {
    for (UserCourseProgress c in myCourses) {
      if (c.course.id == course.id) {
        for (CourseModuleModel m in c.completedModules) {
          if (m.id == module.id) {
            return true;
          }
        }
      }
    }

    return false;
  }

  void addCourseToSavedOnes(CourseModel course) {
    if (!alreadyStatedCourse(course)) {
      myCourses.add(UserCourseProgress(
        course: course,
        completedModules: [],
      ));
    }
  }

  void setCompletedModule(CourseModuleModel module) {
    for (UserCourseProgress c in myCourses) {
      for (CourseModuleModel m in c.course.modules) {
        if (m.id == module.id) {
          if (!alreadyCompletedModule(c.course, module)) {
            c.completedModules.add(module);
          }
        }
      }
    }
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
    for (UserCourseProgress c in myCourses) {
      if (c.course.id == course.id) {
        int completed = c.completedModules.length;
        int total = c.course.modules.length;

        return (completed * 100) / total;
      }
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

  List<Map<String, dynamic>> progressToMapList() {
    List<Map<String, dynamic>> list = [];

    for (UserCourseProgress course in myCourses) {
      List<String> completedModules = [];

      for (CourseModuleModel module in course.completedModules) {
        completedModules.add(module.id);
      }

      list.add({
        'course_id': course.course.ref,
        'completed_modules': completedModules,
      });
    }

    return list;
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
