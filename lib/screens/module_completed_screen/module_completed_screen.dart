import 'package:flutter/material.dart';

import '../../widgets/rounded_button/rounded_button.dart';

class ModuleCompletedScreen extends StatelessWidget {
  const ModuleCompletedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _backToHome() {
      return RoundedButton(
        text: 'Voltar ao início',
        onPress: () => Navigator.of(context).pushNamedAndRemoveUntil(
          'main',
          (route) => false,
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          const Text('Você terminou o módulo com sucesso.'),
          const Spacer(),
          _backToHome(),
        ],
      ),
    );
  }
}
