import 'package:flutter/material.dart';

import '../../models/course_model.dart';
import '../../models/course_module_model.dart';
import '../../themes/theme.dart';

class ModuleItem extends StatelessWidget {
  final CourseModuleModel module;
  final CourseModel course;
  final bool locked;

  const ModuleItem({
    Key? key,
    required this.module,
    required this.course,
    required this.locked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void handlePress() {
      Navigator.of(context).pushNamed('module', arguments: {
        'module': module,
        'course': course,
      });
    }

    Widget _progress() {
      Widget _progressIndicator() {
        return CircularProgressIndicator(
          value: locked ? 0 : .38,
          backgroundColor: kSecondaryText.withOpacity(.1),
          strokeWidth: 8,
          color: kPrimary,
        );
      }

      Widget _icon() {
        return Icon(
          module.icon,
          color: kSecondaryText.withOpacity(.2),
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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          _progress(),
          const SizedBox(height: 30),
          _moduleName(),
        ],
      ),
    );
  }
}
