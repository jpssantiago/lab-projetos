import 'course_model.dart';

class UserCourseProgress {
  CourseModel course;

  UserCourseProgress({required this.course});

  static Future<UserCourseProgress> fromMap(dynamic map) async {
    final doc = await map['course_id'].get();
    final data = await doc.data();

    return UserCourseProgress(
      course: CourseModel.fromMap(id: doc.id, map: data),
    );
  }
}
