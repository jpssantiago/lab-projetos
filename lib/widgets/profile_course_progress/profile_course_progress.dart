import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../models/course_model.dart';
import '../../themes/theme.dart';
import '../course_details_bottom_sheet/course_details_bottom_sheet.dart';

class ProfileCourseProgress extends StatelessWidget {
  final CourseModel course;
  final double progress;

  const ProfileCourseProgress({
    Key? key,
    required this.course,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _image() {
      return ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: CachedNetworkImage(
          imageUrl: course.logo,
          width: 30,
          height: 30,
        ),
      );
    }

    Widget _courseName() {
      return Text(
        course.name,
        style: const TextStyle(
          fontSize: 16,
          color: kText,
        ),
      );
    }

    Widget _progress() {
      Widget _progressIndicator() {
        return SizedBox(
          width: 48,
          height: 48,
          child: CircularProgressIndicator(
            value: (progress) / 100,
            color: kPrimary,
            backgroundColor: kIce,
            strokeWidth: 3,
          ),
        );
      }

      Widget _progressText() {
        return Text(
          '${progress.toStringAsFixed(0)} %',
          style: TextStyle(
            color: (progress) > 0 ? kPrimary : kSecondaryText.withOpacity(.5),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        );
      }

      return Stack(
        alignment: Alignment.center,
        children: [
          _progressIndicator(),
          _progressText(),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () {
          showCourseDetailsBottomSheet(context: context, course: course);
        },
        child: Container(
          color: kWhite,
          height: 70,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _image(),
              const SizedBox(width: 15),
              _courseName(),
              const Spacer(),
              _progress(),
            ],
          ),
        ),
      ),
    );
  }
}
