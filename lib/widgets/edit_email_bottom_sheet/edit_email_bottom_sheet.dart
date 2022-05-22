import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../bottom_sheet/bottom_sheet.dart';
import '../filled_button/filled_button.dart';
import '../filled_text_field/filled_text_field.dart';

class EditEmailBottomSheet extends StatelessWidget {
  final Function() onFinish;

  const EditEmailBottomSheet({
    Key? key,
    required this.onFinish,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final authProvider = Provider.of<AuthProvider>(context);

    Widget _input() {
      return FilledTextField(
        controller: controller,
        hint: authProvider.email,
      );
    }

    Widget _button() {
      return FilledButton(
        text: 'Salvar email',
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

void showEditEmailBottomSheet({
  required BuildContext context,
  required Function() onFinish,
}) {
  createBottomSheet(
    context: context,
    title: 'Editar email',
    child: EditEmailBottomSheet(onFinish: onFinish),
  );
}
