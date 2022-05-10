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
