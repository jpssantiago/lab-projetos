import 'package:flutter/material.dart';

import '../../models/course_module_model.dart';
import '../../models/lesson_model.dart';
import '../../themes/theme.dart';
import '../../widgets/alert_dialog/alert_dialog.dart';
import '../lesson_screen/lesson_screen.dart';

class ModuleScreen extends StatefulWidget {
  const ModuleScreen({Key? key}) : super(key: key);

  @override
  State<ModuleScreen> createState() => _ModuleScreenState();
}

class _ModuleScreenState extends State<ModuleScreen> {
  final PageController controller = PageController();
  int _currentLesson = 0;

  void setCurrentLesson(int index) {
    setState(() {
      _currentLesson = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final map = args as Map<String, dynamic>;
    final CourseModuleModel module = map['module'] as CourseModuleModel;

    AppBar _appBar() {
      Widget _close() {
        return IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            showConfirmationDialog(
              context: context,
              title: 'Você tem certeza que deseja sair?',
              text:
                  'O seu progresso será salvo até esse ponto. Você poderá continuar de onde parou quando quiser.',
              onAccept: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            );
          },
        );
      }

      PreferredSize _bottom() {
        double progress = _currentLesson / module.lessons.length;

        return PreferredSize(
          preferredSize: const Size(double.infinity, 1),
          child: LinearProgressIndicator(
            value: progress,
            color: kPrimary,
            backgroundColor: kSecondaryText.withOpacity(.2),
          ),
        );
      }

      return AppBar(
        leading: _close(),
        title: Text(module.name),
        centerTitle: true,
        bottom: _bottom(),
      );
    }

    void handleSubmit() {
      if (_currentLesson + 1 < module.lessons.length) {
        setCurrentLesson(_currentLesson + 1);

        controller.animateToPage(
          _currentLesson,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
          'module_completed',
          (route) => false,
        );
      }
    }

    List<Widget> _children() {
      List<Widget> children = [];

      for (LessonModel lesson in module.lessons) {
        children.add(
          LessonScreen(lesson: lesson, onSubmit: handleSubmit),
        );
      }

      return children;
    }

    return Scaffold(
      appBar: _appBar(),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: _children(),
      ),
    );
  }
}
