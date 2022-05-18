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
    bool hasCode = lesson.code != null && lesson.code!.isNotEmpty;

    Color background = kSecondaryText.withOpacity(.1);
    Color contrast = kSecondaryText.withOpacity(.2);

    // const Color background = Color(0xFF292B48);
    // const Color contrast = Color(0xFF3E416E);

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

    Widget _buildCode() {
      Widget _fileName() {
        return Container(
          width: double.infinity,
          color: background,
          padding: const EdgeInsets.all(15),
          child: const Text(
            'script.py',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: kSecondaryText,
            ),
          ),
        );
      }

      Widget _divider() {
        return Container(
          height: 2,
          decoration: BoxDecoration(
            color: contrast,
            border: Border.all(color: contrast),
          ),
        );
      }

      Widget _content() {
        String text = lesson.code ?? '';

        return Container(
          width: double.infinity,
          // constraints: const BoxConstraints(
          //   minHeight: 100,
          // ),
          padding: const EdgeInsets.all(15),
          color: background,
          child: Text(
            text.replaceAll('\\n', '\n').replaceAll('\\t', '\t'),
            style: const TextStyle(
              color: kSecondaryText,
              fontSize: 16,
              letterSpacing: 1.2,
              wordSpacing: 2,
            ),
          ),
        );
      }

      return Column(
        children: [
          _fileName(),
          _divider(),
          _content(),
        ],
      );
    }

    Widget _buildBody() {
      return Column(
        children: [
          _buildContent(),
          hasCode ? const SizedBox(height: 20) : Container(),
          hasCode ? _buildCode() : Container(),
        ],
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
        _buildBody(),
        _nextButton(),
      ],
    );
  }
}
