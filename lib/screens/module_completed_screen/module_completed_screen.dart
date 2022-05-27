import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/course_module_model.dart';
import '../../providers/course_provider.dart';
import '../../providers/user_provider.dart';
import '../../themes/theme.dart';
import '../../widgets/rounded_button/rounded_button.dart';

class ModuleCompletedScreen extends StatefulWidget {
  const ModuleCompletedScreen({Key? key}) : super(key: key);

  @override
  State<ModuleCompletedScreen> createState() => _ModuleCompletedScreenState();
}

class _ModuleCompletedScreenState extends State<ModuleCompletedScreen> {
  bool loading = false;

  void setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final module = args as CourseModuleModel;

    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    final courseProvider = Provider.of<CourseProvider>(
      context,
      listen: false,
    );

    Widget _icon() {
      return Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: kPrimary.withOpacity(.2),
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(
            Icons.emoji_events,
            color: kPrimary,
            size: 40,
          ),
        ),
      );
    }

    Widget _title() {
      return const Text(
        'Parabéns!',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: kText,
        ),
      );
    }

    Widget _subtitle() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          'Você concluiu o módulo \'${module.name}\' com sucesso. Você agora pode avançar para os próximos módulos do curso.',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: kSecondaryText,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    Widget _backToHome() {
      return RoundedButton(
        text: 'Voltar ao início',
        loading: loading,
        onPress: () async {
          final course = courseProvider.getCourseByModule(module);

          setLoading(true);
          await userProvider.setModuleCompleted(course, module);
          setLoading(false);

          Navigator.of(context).pushNamedAndRemoveUntil(
            'main',
            (route) => false,
          );
        },
      );
    }

    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          _icon(),
          const SizedBox(height: 20),
          _title(),
          const SizedBox(height: 10),
          _subtitle(),
          const Spacer(),
          _backToHome(),
        ],
      ),
    );
  }
}
