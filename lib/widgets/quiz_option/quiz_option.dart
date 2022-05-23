import 'package:flutter/material.dart';

import '../../themes/theme.dart';

class QuizOption extends StatelessWidget {
  final String option;
  final Function(String) onPress;
  final bool selected;
  final bool correctOption;
  final bool showAnswer;

  const QuizOption({
    Key? key,
    required this.option,
    required this.onPress,
    required this.selected,
    required this.correctOption,
    required this.showAnswer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color green = Colors.green.withOpacity(.9);
    Color red = Colors.red.withOpacity(.9);

    Widget _text() {
      Color _color() {
        if (showAnswer) {
          if (correctOption) {
            return green;
          }

          if (selected) {
            return red;
          }

          return kSecondaryText;
        }

        return selected ? kPrimary : kSecondaryText;
      }

      return Text(
        option,
        style: TextStyle(
          color: _color(),
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      );
    }

    Widget _result() {
      if (showAnswer) {
        if (correctOption) {
          return Icon(
            Icons.check,
            color: green,
          );
        }

        if (selected) {
          return Icon(
            Icons.close,
            color: red,
          );
        }
      }

      return Container();
    }

    Border _border() {
      if (showAnswer) {
        if (correctOption) {
          return Border.all(
            color: green,
          );
        }

        if (selected) {
          return Border.all(
            color: red,
          );
        }

        return Border.all(color: kWhite);
      }

      return Border.all(
        color: selected ? kPrimary : kWhite,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextButton(
        child: Container(
          width: double.infinity,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: _border(),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              _text(),
              const Spacer(),
              _result(),
            ],
          ),
        ),
        onPressed: () => onPress(option), // TODO: Som de erro/acerto ???
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          elevation: MaterialStateProperty.all(.5),
          backgroundColor: MaterialStateProperty.all(kWhite),
        ),
      ),
    );
  }
}
