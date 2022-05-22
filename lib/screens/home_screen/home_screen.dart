import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/course_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/app_bar_button/app_bar_button.dart';
import '../../widgets/select_course_bottom_sheet/select_course_bottom_sheet.dart';
import '../../themes/theme.dart';
import '../../widgets/module_item/module_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final bool loading = userProvider.selectedCourse == null;

    AppBar _appBar() {
      Widget _leading() {
        Widget _selectedCourse() {
          return Text(
            userProvider.selectedCourse?.name ?? 'Curso',
            style: const TextStyle(fontSize: 16),
          );
        }

        Widget _chevronDown() {
          return const Icon(Icons.expand_more, size: 22);
        }

        return AppBarButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _selectedCourse(),
              const SizedBox(width: 2),
              _chevronDown(),
            ],
          ),
          onPressed: () {
            if (loading) return;

            showSelectCourseBottomSheet(context: context);
          },
        );
      }

      return AppBar(
        leading: _leading(),
        leadingWidth: 500,
      );
    }

    Widget _loading() {
      return const Center(
        child: CircularProgressIndicator(color: kPrimary),
      );
    }

    Widget _listView() {
      if (userProvider.selectedCourse == null) {
        return Container();
      }

      Future<void> onRefresh() async {
        final courseProvider = Provider.of<CourseProvider>(
          context,
          listen: false,
        );

        await courseProvider.loadCourses();
        await userProvider.loadUser(
          id: userProvider.user!.id,
          courses: courseProvider.courses,
        );
      }

      return RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: userProvider.selectedCourse?.modules.length,
          itemBuilder: (context, index) {
            return ModuleItem(
              module: userProvider.selectedCourse!.modules[index],
              course: userProvider.selectedCourse!,
              locked: index > 0,
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: _appBar(),
      body: loading ? _loading() : _listView(),
    );
  }
}
