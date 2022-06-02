import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/course_model.dart';
import '../../models/course_module_model.dart';
import '../../providers/user_provider.dart';
import '../../themes/theme.dart';
import '../snack_bar/snack_bar.dart';

class ModuleItem extends StatelessWidget {
  final CourseModuleModel module;
  final CourseModel course;
  final bool showSteps;

  const ModuleItem({
    Key? key,
    required this.module,
    required this.course,
    required this.showSteps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    double progress = userProvider.user?.getModuleProgress(course, module) ?? 0;
    bool completed = progress == 100;

    void handlePress() {
      if (module.lessons.isEmpty) {
        sendSnackBar(
          context: context,
          message: 'Este módulo não tem lições disponíveis.',
        );
        return;
      }

      Navigator.of(context).pushNamed('module', arguments: {
        'module': module,
        'course': course,
      });
    }

    Widget _progress() {
      Widget _progressIndicator() {
        return CircularProgressIndicator(
          value: userProvider.user?.getModuleProgress(course, module),
          backgroundColor: kSecondaryText.withOpacity(.1),
          strokeWidth: 8,
          color: kPrimary,
        );
      }

      bool locked = module.lessons.isEmpty;
      Widget _icon() {
        return Icon(
          locked ? Icons.lock : module.icon,
          color: completed ? kPrimary : kSecondaryText.withOpacity(.2),
          size: 48,
        );
      }

      return TextButton(
        child: Container(
          width: 120,
          height: 120,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              _progressIndicator(),
              _icon(),
            ],
          ),
        ),
        onPressed: handlePress,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          shape: MaterialStateProperty.all(const CircleBorder()),
          backgroundColor: MaterialStateProperty.all(kWhite),
        ),
      );
    }

    Widget _moduleName() {
      return GestureDetector(
        onTap: handlePress,
        child: Text(
          module.name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: kSecondaryText.withOpacity(.9),
          ),
        ),
      );
    }

    Widget _steps() {
      Widget _step() {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: completed ? kPrimary : kSecondaryText.withOpacity(.2),
              shape: BoxShape.circle,
            ),
          ),
        );
      }

      return Column(
        children: [
          _step(),
          _step(),
          _step(),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          _progress(),
          const SizedBox(height: 20),
          _moduleName(),
          showSteps ? const SizedBox(height: 35) : Container(),
          showSteps ? _steps() : Container(),
        ],
      ),
    );
  }
}
