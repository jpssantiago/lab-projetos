import 'package:flutter/material.dart';

import '../../themes/theme.dart';

class FilledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final TextInputType? type;
  final bool? obscureText;
  final Widget? suffix;
  final Function(String)? onChanged;

  const FilledTextField({
    Key? key,
    required this.controller,
    this.hint,
    this.type,
    this.obscureText,
    this.suffix,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: kSecondaryText.withOpacity(.1),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            suffixIcon: suffix,
          ),
          keyboardType: type,
          obscureText: obscureText ?? false,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
