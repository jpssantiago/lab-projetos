import 'package:flutter/material.dart';

import '../../models/lesson_model.dart';
import '../../themes/theme.dart';
import '../../widgets/rounded_button/rounded_button.dart';

class LessonScreen extends StatelessWidget {
  final LessonModel lesson;
  final Function() onSubmit;

  const LessonScreen({
    Key? key,
    required this.lesson,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      return Padding(
        padding: const EdgeInsets.all(15),
        child: Text(
          lesson.content?.replaceAll('\\n', '\n') ?? '',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: kSecondaryText,
          ),
        ),
      );
    }

    Widget _nextButton() {
      return RoundedButton(
        text: 'Continuar',
        onPress: onSubmit,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildContent(),
        _nextButton(),
      ],
    );
  }
}
