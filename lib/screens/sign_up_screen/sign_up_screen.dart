import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../themes/theme.dart';
import '../../widgets/filled_button/filled_button.dart';
import '../../widgets/filled_text_field/filled_text_field.dart';
import '../../widgets/show_password_text_button/show_password_text_button.dart';
import '../../widgets/snack_bar/snack_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfController = TextEditingController();

  bool hidePassword = true;
  bool hidePasswordConf = true;

  bool lengthRequirement = false;
  bool confirmationRequirement = false;

  bool loading = false;

  void toggleHidePassword() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  void toggleHidePasswordConf() {
    setState(() {
      hidePasswordConf = !hidePasswordConf;
    });
  }

  void checkRequirements() {
    setState(() {
      String password = passwordController.text;
      String confirmation = passwordConfController.text;

      lengthRequirement = password.length >= 6;
      confirmationRequirement = password.isNotEmpty && password == confirmation;
    });
  }

  void setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);

    AppBar _appBar() {
      return AppBar(
        title: const Text('Não tenho uma conta'),
        centerTitle: true,
      );
    }

    Widget _title() {
      return const Text(
        'Crie uma conta para continuar',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: kText,
        ),
      );
    }

    Widget _nameTextField() {
      return FilledTextField(
        controller: nameController,
        hint: 'Nome',
        type: TextInputType.text,
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
        onChanged: (str) => checkRequirements(),
      );
    }

    Widget _passwordConfTextField() {
      return FilledTextField(
        controller: passwordConfController,
        hint: 'Confirmar senha',
        type: TextInputType.text,
        obscureText: hidePasswordConf,
        suffix: ShowPasswordTextButton(
          showPassword: !hidePasswordConf,
          onPress: toggleHidePasswordConf,
        ),
        onChanged: (str) => checkRequirements(),
      );
    }

    Widget _lengthRequirement() {
      return Text(
        'A senha precisa ter pelo menos 6 caracteres.',
        style: TextStyle(
          color: lengthRequirement ? kPrimary : kText,
        ),
      );
    }

    Widget _confirmationRequirement() {
      return Text(
        'As senhas devem ser iguais.',
        style: TextStyle(
          color: confirmationRequirement ? kPrimary : kText,
        ),
      );
    }

    Widget _button() {
      return FilledButton(
        text: 'Criar conta',
        loading: loading,
        onPressed: () async {
          String name = nameController.text;
          String email = emailController.text;
          String password = passwordController.text;
          String confirmation = passwordConfController.text;

          if (name.isEmpty ||
              email.isEmpty ||
              password.isEmpty ||
              confirmation.isEmpty) {
            return; // Error
          }

          if (!lengthRequirement || !confirmationRequirement) {
            return; // Error;
          }

          setLoading(true);

          final response = await authProvider.signUp(name, email, password);
          if (response.authenticated) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              'main',
              (route) => false,
            );
          } else {
            sendSnackBar(context: context, message: response.error ?? '');
          }

          setLoading(false);
        },
      );
    }

    Widget _signIn() {
      return Center(
        child: TextButton(
          child: RichText(
            text: const TextSpan(
              text: 'Já possui uma conta? ',
              style: TextStyle(color: kText),
              children: [
                TextSpan(
                  text: 'Entre agora.',
                  style: TextStyle(color: kPrimary),
                ),
              ],
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: size.height - AppBar().preferredSize.height,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title(),
                const SizedBox(height: 20),
                _nameTextField(),
                const SizedBox(height: 10),
                _emailTextField(),
                const SizedBox(height: 10),
                _passwordTextField(),
                const SizedBox(height: 10),
                _passwordConfTextField(),
                const SizedBox(height: 20),
                _lengthRequirement(),
                const SizedBox(height: 5),
                _confirmationRequirement(),
                const SizedBox(height: 20),
                _button(),
                const SizedBox(height: 5),
                _signIn(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
