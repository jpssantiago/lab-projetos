import './course_module_model.dart';

class CourseModel {
  String id;
  String name;
  String logo;
  List<CourseModuleModel> modules;

  CourseModel({
    required this.id,
    required this.name,
    required this.logo,
    required this.modules,
  });

  static CourseModel fromMap({
    required String id,
    required Map<String, dynamic> map,
  }) {
    return CourseModel(
      id: id,
      name: map['name'],
      logo: map['logo'],
      modules: CourseModuleModel.fromMapList(map['modules']),
    );
  }
}
