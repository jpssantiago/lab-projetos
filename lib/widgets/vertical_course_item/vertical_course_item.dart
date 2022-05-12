import 'package:flutter/material.dart';

import '../../models/course_model.dart';
import '../../themes/theme.dart';

class VerticalCourseItem extends StatelessWidget {
  final CourseModel? course;
  final Function(CourseModel)? onSelect;
  final bool? selected;
  final double? progress;

  const VerticalCourseItem({
    Key? key,
    this.course,
    this.onSelect,
    this.selected,
    this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _leftColumn() {
      Widget _courseImage() {
        if (course == null) {
          return Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: kIce,
              borderRadius: BorderRadius.circular(5),
            ),
          );
        }

        return Image.network(
          course!.logo,
          width: 24,
          height: 24,
        );
      }

      Widget _courseName() {
        if (course == null) {
          return Container(
            width: 60,
            height: 22,
            decoration: BoxDecoration(
              color: kIce,
              borderRadius: BorderRadius.circular(5),
            ),
          );
        }

        return Text(
          course!.name,
          style: const TextStyle(fontSize: 16, color: kText),
        );
      }

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _courseImage(),
          const SizedBox(height: 8),
          _courseName(),
        ],
      );
    }

    Widget _progress() {
      Widget _progressIndicator() {
        return SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            value: (progress ?? 0) / 100,
            color: kPrimary,
            backgroundColor: kIce,
            strokeWidth: 3,
          ),
        );
      }

      Widget _progressText() {
        return Text(
          '${progress?.toStringAsFixed(0) ?? '0'} %',
          style: TextStyle(
            color:
                (progress ?? 0) > 0 ? kPrimary : kSecondaryText.withOpacity(.5),
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

    void handlePress() {
      if (course == null) return;

      onSelect!(course!);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          border: selected ?? false
              ? Border.all(color: kPrimary)
              : Border.all(color: kIce),
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextButton(
          onPressed: handlePress,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _leftColumn(),
              _progress(),
            ],
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kWhite),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            ),
          ),
        ),
      ),
    );
  }
}
