import 'package:flutter/material.dart';

import '../bottom_sheet/bottom_sheet.dart';
import '../filled_button/filled_button.dart';
import '../filled_text_field/filled_text_field.dart';

class EditPasswordBottomSheet extends StatelessWidget {
  final Function() onFinish;

  const EditPasswordBottomSheet({
    Key? key,
    required this.onFinish,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    Widget _input() {
      return FilledTextField(
        controller: controller,
        hint: '***********',
      );
    }

    Widget _button() {
      return FilledButton(
        text: 'Enviar instruções',
        // loading: loading,
        onPressed: () {},
      );
    }

    return Column(
      children: [
        _input(),
        const SizedBox(height: 20),
        _button(),
      ],
    );
  }
}

void showEditPasswordBottomSheet({
  required BuildContext context,
  required Function() onFinish,
}) {
  createBottomSheet(
    context: context,
    title: 'Alterar senha',
    child: EditPasswordBottomSheet(onFinish: onFinish),
  );
}
