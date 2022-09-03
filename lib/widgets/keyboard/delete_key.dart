import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viword/constants/colors.dart';
import 'package:viword/constants/game.dart';
import 'package:viword/providers/game_provider.dart';
import 'package:viword/widgets/keyboard/keyboard_key.dart';

class DeleteKey extends StatelessWidget {
  const DeleteKey({Key? key}) : super(key: key);

  void onTap(BuildContext context) {
    context.read<Game>().deleteLetter();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardKey(
      keyVal: delKey,
      onTap: () => onTap(context),
      icon: Icons.backspace,
      backgroundColor: kMediumGrey,
    );
  }
}
