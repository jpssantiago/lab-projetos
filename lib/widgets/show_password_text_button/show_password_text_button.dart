import 'package:flutter/material.dart';

import '../../themes/theme.dart';

class ShowPasswordTextButton extends StatelessWidget {
  final bool showPassword;
  final Function() onPress;

  const ShowPasswordTextButton({
    Key? key,
    required this.showPassword,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      child: Text(
        showPassword ? 'ESCONDER' : 'MOSTRAR',
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: kSecondaryText,
        ),
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      ),
    );
  }
}
