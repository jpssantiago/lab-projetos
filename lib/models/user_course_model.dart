import './course_model.dart';

class UserCourseModel {
  CourseModel course;
  List<int> completedModules;

  UserCourseModel({
    required this.course,
    required this.completedModules,
  });

  static Future<UserCourseModel> fromMap(dynamic map) async {
    final doc = await map['course'].get();
    final data = await doc.data();

    List<int> completedModules = [];
    for (var moduleId in map['completed_modules']) {
      completedModules.add(moduleId as int);
    }

    return UserCourseModel(
      course: CourseModel.fromMap(id: doc.id, map: data),
      completedModules: completedModules,
    );
  }
}
