import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../widgets/app_bar_button/app_bar_button.dart';
import '../../widgets/select_course_bottom_sheet/select_course_bottom_sheet.dart';
import '../../themes/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void loadData() async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    await userProvider.loadUser();
  }

  @override
  void initState() {
    super.initState();

    loadData();
  }

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
      return ListView();
    }

    return Scaffold(
      appBar: _appBar(),
      body: loading ? _loading() : _listView(),
    );
  }
}
