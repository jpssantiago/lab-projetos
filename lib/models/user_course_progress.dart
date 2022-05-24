import 'course_model.dart';

class UserCourseProgress {
  CourseModel course;
  // List<UserModuleProgress> modules;

  UserCourseProgress({
    required this.course,
    // required this.modules,
  });

  static Future<UserCourseProgress> fromMap(dynamic map) async {
    final doc = await map['course_id'].get();
    final data = await doc.data();

    CourseModel course = CourseModel.fromMap(id: doc.id, map: data);

    return UserCourseProgress(
      course: course,
      // modules: UserModuleProgress.fromMapList(course, map['course_progress']),
    );
  }
}
