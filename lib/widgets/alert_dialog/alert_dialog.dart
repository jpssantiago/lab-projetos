import 'package:flutter/material.dart';

import '../../themes/theme.dart';

void showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String text,
  required Function() onAccept,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: kPrimary),
            ),
          ),
          TextButton(
            onPressed: onAccept,
            child: const Text(
              'OK',
              style: TextStyle(color: kPrimary),
            ),
          ),
        ],
      );
    },
  );
}
