import 'package:flutter/material.dart';

import '../../models/course_model.dart';
import '../bottom_sheet/bottom_sheet.dart';

class CourseDetailsBottomSheet extends StatelessWidget {
  final CourseModel course;

  const CourseDetailsBottomSheet({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [],
    );
  }
}

void showCourseDetailsBottomSheet({
  required BuildContext context,
  required CourseModel course,
}) {
  createBottomSheet(
    context: context,
    title: 'Curso de ${course.name}',
    child: CourseDetailsBottomSheet(course: course),
  );
}
