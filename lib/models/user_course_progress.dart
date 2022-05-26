import 'course_model.dart';
import 'course_module_model.dart';

class UserCourseProgress {
  CourseModel course;
  List<CourseModuleModel> completedModules;

  UserCourseProgress({
    required this.course,
    required this.completedModules,
  });

  static List<CourseModuleModel> getModules(
    CourseModel course,
    List<dynamic> list,
  ) {
    List<CourseModuleModel> modules = [];

    for (var item in list) {
      for (CourseModuleModel module in course.modules) {
        if (module.id == item) {
          modules.add(module);
        }
      }
    }

    return modules;
  }

  static Future<UserCourseProgress> fromMap(dynamic map) async {
    final doc = await map['course_id'].get();
    final data = await doc.data();

    CourseModel course = CourseModel.fromMap(id: doc.id, map: data);

    return UserCourseProgress(
      course: course,
      completedModules: getModules(course, map['completed_modules']),
    );
  }
}
