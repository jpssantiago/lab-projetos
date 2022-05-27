import 'package:cloud_firestore/cloud_firestore.dart';

import './course_module_model.dart';

class CourseModel {
  String id;
  String name;
  String logo;
  List<CourseModuleModel> modules;
  DocumentReference ref;

  CourseModel({
    required this.id,
    required this.name,
    required this.logo,
    required this.modules,
    required this.ref,
  });

  static CourseModel fromMap({
    required String id,
    required Map<String, dynamic> map,
    required DocumentReference ref,
  }) {
    return CourseModel(
      id: id,
      name: map['name'],
      logo: map['logo'],
      modules: CourseModuleModel.fromMapList(map['modules']),
      ref: ref,
    );
  }
}
