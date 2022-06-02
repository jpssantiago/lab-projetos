import 'package:flutter/material.dart';

import '../../themes/theme.dart';

void createBottomSheet({
  required BuildContext context,
  required String title,
  required Widget child,
  EdgeInsets? padding,
}) {
  Widget _buildUpperRow() {
    Widget _buildTitle() {
      return Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
      );
    }

    Widget _buildCloseButton() {
      return GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: const Icon(
          Icons.close,
          color: kSecondaryText,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTitle(),
        _buildCloseButton(),
      ],
    );
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    builder: (context) {
      return Container(
        color: kWhite,
        child: SingleChildScrollView(
          padding: padding ?? const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUpperRow(),
              const SizedBox(height: 20),
              child,
              Padding(padding: MediaQuery.of(context).viewInsets),
            ],
          ),
        ),
      );
    },
  );
}
