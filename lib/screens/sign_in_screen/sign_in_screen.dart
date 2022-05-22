import 'package:flutter/material.dart';

import '../../themes/theme.dart';
import '../../widgets/filled_button/filled_button.dart';
import '../../widgets/filled_text_field/filled_text_field.dart';
import '../../widgets/show_password_text_button/show_password_text_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;
  bool loading = false;

  void toggleHidePassword() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  void setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppBar _appBar() {
      return AppBar(
        title: const Text('Já tenho uma conta'),
        centerTitle: true,
      );
    }

    Widget _title() {
      return const Text(
        'Entre com sua conta',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: kText,
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

    Widget _passwordTextField() {
      return FilledTextField(
        controller: passwordController,
        hint: 'Senha',
        type: TextInputType.text,
        obscureText: hidePassword,
        suffix: ShowPasswordTextButton(
          showPassword: !hidePassword,
          onPress: toggleHidePassword,
        ),
      );
    }

    Widget _recoverPassword() {
      return TextButton(
        child: const Text(
          'Esqueceu a senha?',
          style: TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed('password_recovery');
        },
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          foregroundColor: MaterialStateProperty.all(kText),
        ),
      );
    }

    Widget _button() {
      return FilledButton(
        text: 'Conectar',
        loading: loading,
        onPressed: () async {},
      );
    }

    Widget _signUp() {
      return Center(
        child: TextButton(
          child: RichText(
            text: const TextSpan(
              text: 'Não possui uma conta? ',
              style: TextStyle(color: kText),
              children: [
                TextSpan(
                  text: 'Crie uma agora.',
                  style: TextStyle(color: kPrimary),
                ),
              ],
            ),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed('sign_up');
          },
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            foregroundColor: MaterialStateProperty.all(kText),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(),
            const SizedBox(height: 20),
            _emailTextField(),
            const SizedBox(height: 10),
            _passwordTextField(),
            const SizedBox(height: 5),
            _recoverPassword(),
            const SizedBox(height: 5),
            _button(),
            const SizedBox(height: 5),
            _signUp(),
          ],
        ),
      ),
    );
  }
}
