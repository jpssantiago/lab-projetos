import 'package:flutter/material.dart';

import '../../themes/theme.dart';
import '../../widgets/filled_button/filled_button.dart';

class PasswordRecoverySuccessScreen extends StatelessWidget {
  const PasswordRecoverySuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _icon() {
      return Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: kPrimary.withOpacity(.2),
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(
            Icons.check,
            color: kPrimary,
            size: 36,
          ),
        ),
      );
    }

    Widget _title() {
      return const Text(
        'Boas novas!',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: kText,
        ),
      );
    }

    Widget _subtitle() {
      return const Text(
        'Nós te enviamos um email com o passo a passo para redefinir a sua senha. Lembre-se de olhar a sua caixa de entrada e a de SPAM também.',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: kSecondaryText,
        ),
        textAlign: TextAlign.center,
      );
    }

    Widget _button() {
      return FilledButton(
        text: 'Voltar ao início',
        onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
            'welcome',
            (route) => false,
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: kWhite,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Spacer(),
            _icon(),
            const SizedBox(height: 20),
            _title(),
            const SizedBox(height: 10),
            _subtitle(),
            const Spacer(),
            _button(),
          ],
        ),
      ),
    );
  }
}
