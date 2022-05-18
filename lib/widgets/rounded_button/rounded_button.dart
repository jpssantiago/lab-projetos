import 'package:flutter/material.dart';

import '../../themes/theme.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function() onPress;

  const RoundedButton({
    Key? key,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextButton(
        onPressed: onPress,
        child: SizedBox(
          height: 35,
          width: double.infinity,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: kWhite,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kPrimary),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          ),
        ),
      ),
    );
  }
}
