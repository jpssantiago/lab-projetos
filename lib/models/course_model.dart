class CourseModel {
  String id;
  String name;
  String logo;

  CourseModel({
    required this.id,
    required this.name,
    required this.logo,
  });

  static CourseModel fromMap({
    required String id,
    required Map<String, dynamic> map,
  }) {
    return CourseModel(
      id: id,
      name: map['name'],
      logo: map['logo'],
    );
  }
}
