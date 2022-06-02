import 'package:flutter/material.dart';

import '../../themes/theme.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function() onPress;
  final bool? disabled;
  final bool? outlined;
  final bool? loading;

  const RoundedButton({
    Key? key,
    required this.text,
    required this.onPress,
    this.disabled,
    this.outlined,
    this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _child() {
      if (loading ?? false) {
        return const Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              color: kWhite,
            ),
          ),
        );
      }

      return Center(
        child: Text(
          text,
          style: TextStyle(
            color: outlined ?? false ? kPrimary : kWhite,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: disabled ?? false
                ? kSecondaryText.withOpacity(.3)
                : (outlined ?? false ? kPrimary : kWhite),
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: TextButton(
          onPressed:
              ((loading ?? false) || (disabled ?? false)) ? () {} : onPress,
          child: SizedBox(
            height: 35,
            width: double.infinity,
            child: _child(),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              disabled ?? false
                  ? kSecondaryText.withOpacity(.3)
                  : (outlined ?? false ? kIce : kPrimary),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            ),
          ),
        ),
      ),
    );
  }
}
