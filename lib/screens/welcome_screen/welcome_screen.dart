import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../providers/auth_provider.dart';
import '../../themes/theme.dart';
import '../../utils/error_messages.dart';
import '../../widgets/filled_button/filled_button.dart';
import '../../widgets/snack_bar/snack_bar.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool loading = false;

  void setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  void initState() {
    super.initState();

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.hasUser()) {
      goToMain();
    }
  }

  void goToMain() async {
    await Future.delayed(const Duration(seconds: 0), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        'main',
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    Widget _svg() {
      return SvgPicture.asset(
        'assets/svg/welcome_screen.svg',
        width: 220,
        height: 220,
      );
    }

    Widget _title() {
      return const Text(
        'Aprenda programação do seu celular',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: kText,
        ),
        textAlign: TextAlign.center,
      );
    }

    Widget _subtitle() {
      return const Text(
        'Desenvolva suas habilidades em programação com lições intuitivas, exemplos em código e questionários... Uma linha de cada vez.',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: kSecondaryText,
        ),
        textAlign: TextAlign.center,
      );
    }

    Widget _googleButton() {
      return FilledButton(
        text: 'Continuar com Google',
        background: const Color(0xFFD9D9D9).withOpacity(.5),
        textColor: kText,
        leftWidget: Image.asset(
          'assets/img/google_logo.png',
          width: 20,
          height: 20,
          fit: BoxFit.cover,
        ),
        loading: loading,
        onPressed: () async {
          setLoading(true);

          final response = await authProvider.signInWithGoogle();
          if (response.authenticated) {
            goToMain();
          } else {
            if (response.error != 'user-cancelled') {
              sendSnackBar(
                context: context,
                message: treatAuthErrorMessage(response.error),
              );
            }
          }

          setLoading(false);
        },
      );
    }

    Widget _emaileButton() {
      return FilledButton(
        text: 'Continuar com email',
        leftWidget: const Icon(
          Icons.email,
          color: kWhite,
        ),
        onPressed: () => Navigator.of(context).pushNamed('sign_in'),
      );
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20,
          top: 40,
        ),
        color: kWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            _svg(),
            const SizedBox(height: 30),
            _title(),
            const SizedBox(height: 10),
            _subtitle(),
            const Spacer(),
            _googleButton(),
            const SizedBox(height: 10),
            _emaileButton(),
          ],
        ),
      ),
    );
  }
}
