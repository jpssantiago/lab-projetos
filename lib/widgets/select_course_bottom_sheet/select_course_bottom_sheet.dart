import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/course_provider.dart';
import '../../providers/user_provider.dart';
import '../bottom_sheet/bottom_sheet.dart';
import '../vertical_course_item/vertical_course_item.dart';
import '../../models/course_model.dart';

class SelectCourseBottomSheet extends StatelessWidget {
  const SelectCourseBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final courseProvider = Provider.of<CourseProvider>(context);

    bool loading = courseProvider.courses.isEmpty;

    List<Widget> _children() {
      List<Widget> children = [];

      if (loading) {
        for (int i = 0; i < 3; i++) {
          children.add(const VerticalCourseItem());
        }
      } else {
        for (CourseModel course in courseProvider.courses) {
          children.add(VerticalCourseItem(
            course: course,
            selected: course.id == userProvider.selectedCourse?.id,
            progress: userProvider.user?.getCourseProgress(course),
            onSelect: (course) async {
              userProvider.setSelectedCourse(course);

              await Future.delayed(const Duration(milliseconds: 100), () {});

              Navigator.of(context).pop();
            },
          ));
        }
      }

      return children;
    }

    return Column(
      children: _children(),
    );
  }
}

void showSelectCourseBottomSheet({
  required BuildContext context,
}) {
  createBottomSheet(
    context: context,
    title: 'Cursos disponíveis',
    child: const SelectCourseBottomSheet(),
  );
}
