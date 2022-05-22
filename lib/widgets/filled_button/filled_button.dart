import 'package:flutter/material.dart';

import '../../themes/theme.dart';

class FilledButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool? loading;
  final Color? background;
  final Color? textColor;

  const FilledButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.loading,
    this.background,
    this.textColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget _buildText() {
      if (loading ?? false) {
        return const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            color: kWhite,
          ),
        );
      }

      return Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: textColor ?? kWhite,
        ),
      );
    }

    return TextButton(
      onPressed: loading ?? false ? () {} : onPressed,
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Center(child: _buildText()),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          background ?? kPrimary,
        ),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      ),
    );
  }
}
