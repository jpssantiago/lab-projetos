import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: const Text('Continuar com email'),
              onPressed: () {
                Navigator.of(context).pushNamed('sign_in');
              },
            ),
            const SizedBox(height: 10),
            TextButton(
              child: const Text('Logar com google'),
              onPressed: () async {
                final response = await authProvider.signInWithGoogle();

                if (response.authenticated) {
                  goToMain();
                } else {
                  // [snack-bar] erro: response.error
                  // TODO: Widget de snackbar.
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
