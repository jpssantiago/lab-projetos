import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      body: Center(
        child: TextButton(
          child: const Text('Logar com google'),
          onPressed: () async {
            await userProvider.signInWithGoogle();
          },
        ),
      ),
    );
  }
}
