import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../themes/theme.dart';
import '../bottom_sheet/bottom_sheet.dart';
import '../snack_bar/snack_bar.dart';

class EditAvatarBottomSheet extends StatefulWidget {
  const EditAvatarBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<EditAvatarBottomSheet> createState() => _EditAvatarBottomSheetState();
}

class _EditAvatarBottomSheetState extends State<EditAvatarBottomSheet> {
  bool loading = false;

  void setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    bool hasPicture = userProvider.user?.picture != null;

    Widget _choose() {
      return TextButton(
        child: SizedBox(
          height: 50,
          child: Row(
            children: const [
              Icon(Icons.photo_library),
              SizedBox(width: 10),
              Text('Escolher foto da galeria'),
            ],
          ),
        ),
        onPressed: () async {
          if (loading) return;

          final results = await FilePicker.platform.pickFiles(
            allowMultiple: false,
            type: FileType.custom,
            allowedExtensions: ['png', 'jpg'],
          );

          if (results != null) {
            final path = results.files.single.path;

            setLoading(true);
            final response = await userProvider.setPicture(path ?? '');
            setLoading(false);

            if (response.edited) {
              sendSnackBar(
                context: context,
                message: 'A sua foto de perfil foi alterada.',
              );
            } else {
              sendSnackBar(context: context, message: response.error!);
            }

            Navigator.of(context).pop();
          }
        },
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          foregroundColor: MaterialStateProperty.all(kText),
        ),
      );
    }

    Widget _remove() {
      return TextButton(
        child: SizedBox(
          height: 50,
          child: Row(
            children: const [
              Icon(Icons.remove),
              SizedBox(width: 10),
              Text('Remover foto de perfil'),
            ],
          ),
        ),
        onPressed: () async {
          if (loading) return;

          if (!hasPicture) {
            sendSnackBar(
              context: context,
              message: 'Você não tem uma foto de perfil para remover.',
            );
            return;
          }

          setLoading(true);
          final response = await userProvider.removePicture();
          setLoading(false);

          if (response.removed) {
            sendSnackBar(
              context: context,
              message: 'A sua foto de perfil foi removida.',
            );
          } else {
            sendSnackBar(
              context: context,
              message: 'Não foi possível remover a sua foto de perfil.',
            );
          }

          Navigator.of(context).pop();
        },
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          foregroundColor: MaterialStateProperty.all(kText),
        ),
      );
    }

    return Column(
      children: [
        _choose(),
        const SizedBox(height: 10),
        _remove(),
      ],
    );
  }
}

void showEditAvatarBottomSheet({
  required BuildContext context,
}) {
  createBottomSheet(
    context: context,
    title: 'Editar foto de perfil',
    child: const EditAvatarBottomSheet(),
  );
}
