import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../models/course_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/course_provider.dart';
import '../../providers/user_provider.dart';
import '../../themes/theme.dart';
import '../../widgets/alert_dialog/alert_dialog.dart';
import '../../widgets/edit_avatar_bottom_sheet/edit_avatar_bottom_sheet.dart';
import '../../widgets/edit_email_bottom_sheet/edit_email_bottom_sheet.dart';
import '../../widgets/edit_name_bottom_sheet/edit_name_bottom_sheet.dart';
import '../../widgets/edit_password_bottom_sheet/edit_password_bottom_sheet.dart';
import '../../widgets/profile_course_progress/profile_course_progress.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    Widget _header() {
      String picture =
          userProvider.user?.picture ?? 'https://github.com/rocketseat.png';

      Widget _avatar() {
        return GestureDetector(
          onTap: () {
            showEditAvatarBottomSheet(context: context);
          },
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: kIce,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: kPrimary),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CachedNetworkImage(imageUrl: picture, fit: BoxFit.cover),
            ),
          ),
        );
      }

      Widget _name() {
        return Text(
          userProvider.user?.name ?? '',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: kText,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        );
      }

      Widget _editAvatar() {
        return GestureDetector(
          onTap: () {
            showEditAvatarBottomSheet(context: context);
          },
          child: const Text(
            'Editar foto de perfil',
            style: TextStyle(
              color: kPrimary,
              fontSize: 14,
            ),
          ),
        );
      }

      return Container(
        color: kWhite,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            _avatar(),
            const SizedBox(height: 20),
            _name(),
            const SizedBox(height: 10),
            _editAvatar(),
          ],
        ),
      );
    }

    Widget _progress() {
      List<Widget> children = [];

      for (CourseModel course in courseProvider.courses) {
        children.add(
          ProfileCourseProgress(
            course: course,
            progress: userProvider.user?.getCourseProgress(course) ?? 0,
          ),
        );
      }

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        color: kWhite,
        child: Column(
          children: children,
        ),
      );
    }

    Widget _account() {
      String email = authProvider.email ?? '';

      Widget _email() {
        return ListTile(
          title: const Text('Email'),
          subtitle: Text(
            email,
            style: const TextStyle(color: kPrimary),
          ),
          onTap: () {
            showEditEmailBottomSheet(context: context, onFinish: () {});
          },
        );
      }

      Widget _name() {
        String name = userProvider.user?.name ?? '';

        return ListTile(
          title: const Text('Nome'),
          subtitle: Text(
            name,
            style: const TextStyle(color: kPrimary),
          ),
          onTap: () {
            showEditNameBottomSheet(context: context, onFinish: () {});
          },
        );
      }

      Widget _password() {
        return ListTile(
          title: const Text('Alterar senha'),
          onTap: () {
            showEditPasswordBottomSheet(context: context, onFinish: () {});
          },
        );
      }

      return Container(
        color: kWhite,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          children: [
            _email(),
            _name(),
            _password(),
          ],
        ),
      );
    }

    Widget _signOut() {
      return Container(
        color: kWhite,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: ListTile(
          title: const Text(
            'Sair',
            style: TextStyle(color: kPrimary),
          ),
          onTap: () {
            showConfirmationDialog(
              context: context,
              title: 'Você tem certeza que deseja sair?',
              text:
                  'Você voltará para a tela de autenticação e precisará entrar com uma conta para continuar utilizando o aplicativo.',
              onAccept: () async {
                Navigator.of(context).pop();

                authProvider.signOut();

                await Future.delayed(const Duration(seconds: 0), () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    'welcome',
                    (route) => false,
                  );
                });
              },
            );
          },
        ),
      );
    }

    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          _header(),
          const SizedBox(height: 5),
          _progress(),
          const SizedBox(height: 5),
          _account(),
          const SizedBox(height: 5),
          _signOut(),
        ],
      ),
    );
  }
}
