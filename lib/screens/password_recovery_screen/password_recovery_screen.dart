import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../themes/theme.dart';
import '../../utils/error_messages.dart';
import '../../widgets/filled_button/filled_button.dart';
import '../../widgets/filled_text_field/filled_text_field.dart';
import '../../widgets/snack_bar/snack_bar.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({Key? key}) : super(key: key);

  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  final emailController = TextEditingController();

  bool loading = false;

  void setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    AppBar _appBar() {
      return AppBar(
        title: const Text('Redefinir senha'),
        centerTitle: true,
      );
    }

    Widget _title() {
      return const Text(
        'Esqueceu a senha?',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: kText,
        ),
      );
    }

    Widget _subtitle() {
      return const Text(
        'Sem problemas! Informe o email da sua conta abaixo para receber o passo a passo para redefinir sua senha.',
        style: TextStyle(
          color: kSecondaryText,
        ),
      );
    }

    Widget _emailTextField() {
      return FilledTextField(
        controller: emailController,
        hint: 'Email',
        type: TextInputType.emailAddress,
      );
    }

    Widget _button() {
      return FilledButton(
        text: 'Continuar',
        loading: loading,
        onPressed: () async {
          String email = emailController.text;
          if (email.isEmpty) {
            sendSnackBar(
              context: context,
              message: 'Preencha todos os campos para continuar.',
            );
            return;
          }

          setLoading(true);

          final response = await authProvider.sendPasswordRecoveryEmail(email);
          if (response.sent) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              'password_recovery_success',
              (route) => false,
            );
          } else {
            sendSnackBar(
              context: context,
              message: treatAuthErrorMessage(response.error),
            );
          }

          setLoading(false);
        },
      );
    }

    return Scaffold(
      appBar: _appBar(),
      backgroundColor: kWhite,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(),
            const SizedBox(height: 10),
            _subtitle(),
            const SizedBox(height: 20),
            _emailTextField(),
            const SizedBox(height: 20),
            _button(),
          ],
        ),
      ),
    );
  }
}
