import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../themes/theme.dart';
import '../../utils/error_messages.dart';
import '../bottom_sheet/bottom_sheet.dart';
import '../filled_button/filled_button.dart';
import '../snack_bar/snack_bar.dart';

class EditPasswordBottomSheet extends StatefulWidget {
  final Function() onFinish;

  const EditPasswordBottomSheet({
    Key? key,
    required this.onFinish,
  }) : super(key: key);

  @override
  State<EditPasswordBottomSheet> createState() =>
      _EditPasswordBottomSheetState();
}

class _EditPasswordBottomSheetState extends State<EditPasswordBottomSheet> {
  bool loading = false;

  void setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final email = authProvider.email ?? '';

    Widget _text() {
      return Text(
        'Você receberá um email no endereço eletrônico "$email" com o passo a passo para redefinir sua senha. Verifique a caixa de entrada e a de SPAM também.',
        style: const TextStyle(
          color: kSecondaryText,
          fontSize: 14,
        ),
      );
    }

    Widget _button() {
      return FilledButton(
        text: 'Enviar instruções',
        loading: loading,
        onPressed: () async {
          setLoading(true);
          final response = await authProvider.sendPasswordRecoveryEmail(
            authProvider.email ?? '',
          );
          setLoading(false);

          if (response.sent) {
            sendSnackBar(
              context: context,
              message: 'O email com instruções foi enviado.',
            );
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _text(),
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
