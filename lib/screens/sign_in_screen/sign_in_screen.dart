import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../themes/theme.dart';
import '../../utils/error_messages.dart';
import '../../widgets/filled_button/filled_button.dart';
import '../../widgets/filled_text_field/filled_text_field.dart';
import '../../widgets/show_password_text_button/show_password_text_button.dart';
import '../../widgets/snack_bar/snack_bar.dart';

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
    final authProvider = Provider.of<AuthProvider>(context);

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
        onPressed: () async {
          String email = emailController.text;
          String password = passwordController.text;

          if (email.isEmpty || password.isEmpty) {
            sendSnackBar(
              context: context,
              message: 'Preencha todos os campos para continuar.',
            );
            return;
          }

          setLoading(true);

          final response = await authProvider.signIn(email, password);
          if (response.authenticated) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              'main',
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
