import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../utils/error_messages.dart';
import '../bottom_sheet/bottom_sheet.dart';
import '../filled_button/filled_button.dart';
import '../filled_text_field/filled_text_field.dart';
import '../snack_bar/snack_bar.dart';

class EditEmailBottomSheet extends StatefulWidget {
  final Function() onFinish;

  const EditEmailBottomSheet({
    Key? key,
    required this.onFinish,
  }) : super(key: key);

  @override
  State<EditEmailBottomSheet> createState() => _EditEmailBottomSheetState();
}

class _EditEmailBottomSheetState extends State<EditEmailBottomSheet> {
  bool loading = false;

  void setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final authProvider = Provider.of<AuthProvider>(context);

    Widget _input() {
      return FilledTextField(
        controller: controller,
        hint: authProvider.email,
        type: TextInputType.emailAddress,
      );
    }

    Widget _button() {
      return FilledButton(
        text: 'Salvar email',
        loading: loading,
        onPressed: () async {
          String email = controller.text;
          if (email.isEmpty) {
            return;
          }

          setLoading(true);
          final response = await authProvider.editEmail(email);
          setLoading(false);

          if (response.edited) {
            sendSnackBar(context: context, message: 'O email foi editado.');
          } else {
            sendSnackBar(
              context: context,
              message: treatAuthErrorMessage(response.error),
            );
          }

          Navigator.of(context).pop();
        },
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
