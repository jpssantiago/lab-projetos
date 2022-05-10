import 'package:flutter/material.dart';

import '../themes/theme.dart';

class AppBarButton extends StatelessWidget {
  final Widget child;
  final Function() onPressed;

  const AppBarButton({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextButton(
        onPressed: onPressed,
        child: child,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          backgroundColor: MaterialStateProperty.all(kIce),
          foregroundColor: MaterialStateProperty.all(kSecondaryText),
        ),
      ),
    );
  }
}
