import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import './firebase_options.dart';
import './providers/course_provider.dart';
import './providers/user_provider.dart';
import './screens/main_screen/main_screen.dart';
import './screens/module_screen/module_screen.dart';
import './themes/theme.dart';
import 'providers/auth_provider.dart';
import 'screens/module_completed_screen/module_completed_screen.dart';
import 'screens/password_recovery_screen/password_recovery_screen.dart';
import 'screens/password_recovery_success_screen/password_recovery_success_screen.dart';
import 'screens/sign_in_screen/sign_in_screen.dart';
import 'screens/sign_up_screen/sign_up_screen.dart';
import 'screens/welcome_screen/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: Colors.white, // status bar color
  ));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CourseProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Lab. Projetos',
        routes: {
          'welcome': (context) => const WelcomeScreen(),
          'sign_in': (context) => const SignInScreen(),
          'sign_up': (context) => const SignUpScreen(),
          'password_recovery': (context) => const PasswordRecoveryScreen(),
          'password_recovery_success': (context) =>
              const PasswordRecoverySuccessScreen(),
          'main': (context) => const MainScreen(),
          'module': (context) => const ModuleScreen(),
          'module_completed': (context) => const ModuleCompletedScreen(),
        },
        initialRoute: 'welcome',
        theme: getLightTheme,
      ),
    );
  }
}
