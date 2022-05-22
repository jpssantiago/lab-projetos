import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../bottom_sheet/bottom_sheet.dart';
import '../filled_button/filled_button.dart';
import '../filled_text_field/filled_text_field.dart';

class EditNameBottomSheet extends StatelessWidget {
  final Function() onFinish;

  const EditNameBottomSheet({
    Key? key,
    required this.onFinish,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final userProvider = Provider.of<UserProvider>(context);

    Widget _input() {
      return FilledTextField(
        controller: controller,
        hint: userProvider.user?.name,
      );
    }

    Widget _button() {
      return FilledButton(
        text: 'Salvar nome',
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

void showEditNameBottomSheet({
  required BuildContext context,
  required Function() onFinish,
}) {
  createBottomSheet(
    context: context,
    title: 'Editar nome',
    child: EditNameBottomSheet(onFinish: onFinish),
  );
}
