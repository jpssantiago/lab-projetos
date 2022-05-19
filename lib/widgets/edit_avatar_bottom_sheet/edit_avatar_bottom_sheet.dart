import 'package:flutter/material.dart';

import '../../themes/theme.dart';
import '../bottom_sheet/bottom_sheet.dart';

class EditAvatarBottomSheet extends StatelessWidget {
  const EditAvatarBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        onPressed: () {},
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
        onPressed: () {},
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
