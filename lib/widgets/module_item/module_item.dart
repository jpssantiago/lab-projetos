import 'package:flutter/material.dart';

import '../../models/course_module_model.dart';
import '../../themes/theme.dart';

class ModuleItem extends StatelessWidget {
  final CourseModuleModel module;
  final bool locked;

  const ModuleItem({
    Key? key,
    required this.module,
    required this.locked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          locked ? Icons.lock : module.icon,
          color: kSecondaryText.withOpacity(.2),
          size: 48,
        );
      }

      return Container(
        width: 120,
        height: 120,
        decoration: const BoxDecoration(
          color: kWhite,
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
      );
    }

    Widget _moduleName() {
      return Text(
        module.name,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: kSecondaryText.withOpacity(.9),
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
