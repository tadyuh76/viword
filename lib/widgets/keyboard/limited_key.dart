import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viword/constants/colors.dart';
import 'package:viword/providers/game_provider.dart';
import 'package:viword/utils/show_snack_bar.dart';
import 'package:viword/widgets/keyboard/keyboard_key.dart';

class LimitedKey extends StatelessWidget {
  final String keyVal;
  const LimitedKey({Key? key, required this.keyVal}) : super(key: key);

  void onTap(BuildContext context) {
    final isNotPlaying = context.read<Game>().isNotPlaying;
    if (isNotPlaying) return;

    showSnackBar(
      context: context,
      backgroundColor: kRed,
      text: 'Chữ "$keyVal" không có trong Tiếng Việt !',
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardKey(
      keyVal: keyVal,
      onTap: () => onTap(context),
    );
  }
}
