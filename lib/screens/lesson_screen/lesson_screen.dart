import 'package:flutter/material.dart';

import '../../models/lesson_model.dart';
import '../../themes/theme.dart';
import '../../widgets/quiz_option/quiz_option.dart';
import '../../widgets/rounded_button/rounded_button.dart';

class LessonScreen extends StatefulWidget {
  final LessonModel lesson;
  final Function() onSubmit;

  const LessonScreen({
    Key? key,
    required this.lesson,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  String? selectedOption;
  bool answered = false;

  void setSelectedOption(String? option) {
    if (answered) return;

    setState(() {
      if (selectedOption == option) {
        selectedOption = null;
      } else {
        selectedOption = option;
      }
    });
  }

  void setAnswered(bool value) {
    setState(() {
      answered = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color background = kSecondaryText.withOpacity(.1);
    Color contrast = kSecondaryText.withOpacity(.2);

    // const Color background = Color(0xFF292B48);
    // const Color contrast = Color(0xFF3E416E);

    Widget _buildContent() {
      return Padding(
        padding: const EdgeInsets.all(15),
        child: Text(
          widget.lesson.content.replaceAll('\\n', '\n'),
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
        String text = widget.lesson.code ?? '';

        return Container(
          width: double.infinity,
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
      Widget _options() {
        List<Widget> children = [];

        for (String option in widget.lesson.options!) {
          children.add(QuizOption(
            option: option,
            onPress: setSelectedOption,
            selected: selectedOption == option,
            correctOption: widget.lesson.correctOption == option,
            showAnswer: answered,
          ));
        }

        return Column(children: children);
      }

      return Expanded(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            _buildContent(),
            widget.lesson.hasCode ? const SizedBox(height: 20) : Container(),
            widget.lesson.hasCode ? _buildCode() : Container(),
            widget.lesson.hasCode && widget.lesson.isQuiz
                ? const SizedBox(height: 30)
                : Container(),
            widget.lesson.isQuiz ? _options() : Container(),
          ],
        ),
      );
    }

    Widget _button() {
      Widget _nextButton() {
        return RoundedButton(
          text: 'Continuar',
          onPress: widget.onSubmit,
        );
      }

      Widget _submitButton() {
        return RoundedButton(
          text: 'Verificar',
          disabled: selectedOption == null,
          onPress: () {
            if (selectedOption == null) return;

            setAnswered(true);
          },
        );
      }

      Widget _skipButton() {
        return Expanded(
          child: RoundedButton(
            text: 'Pular',
            outlined: true,
            onPress: widget.onSubmit,
          ),
        );
      }

      Widget _retryButton() {
        return Expanded(
          child: RoundedButton(
            text: 'Tentar de novo',
            onPress: () {
              setSelectedOption(null);
              setAnswered(false);
            },
          ),
        );
      }

      if (widget.lesson.isQuiz) {
        if (answered) {
          if (widget.lesson.correctOption != selectedOption) {
            return Row(
              children: [
                _skipButton(),
                _retryButton(),
              ],
            );
          }

          return _nextButton();
        }

        return _submitButton();
      }

      return _nextButton();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildBody(),
        _button(),
      ],
    );
  }
}
