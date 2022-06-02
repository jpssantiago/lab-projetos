import 'package:flutter/material.dart';

import '../../themes/theme.dart';

class FilledButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool? loading;
  final Color? background;
  final Color? textColor;
  final Widget? leftWidget;

  const FilledButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.loading,
    this.background,
    this.textColor,
    this.leftWidget,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget _left() {
      if (loading ?? false || leftWidget == null) {
        return Container();
      }

      return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: leftWidget,
      );
    }

    Widget _buildText() {
      if (loading ?? false) {
        return SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            color: textColor ?? kWhite,
            strokeWidth: 2,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _left(),
            _buildText(),
          ],
        ),
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
