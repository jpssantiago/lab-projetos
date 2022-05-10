class CourseModel {
  String id;
  String name;

  CourseModel({required this.id, required this.name});

  static CourseModel fromMap({
    required String id,
    required Map<String, dynamic> map,
  }) {
    return CourseModel(
      id: id,
      name: map['name'],
    );
  }
}
