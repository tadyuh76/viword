import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viword/constants/breakpoints.dart';
import 'package:viword/constants/colors.dart';
import 'package:viword/constants/game.dart';
import 'package:viword/providers/game_provider.dart';
import 'package:viword/utils/color_changer.dart';

class KeyboardKey extends StatelessWidget {
  final IconData? icon;
  final String keyVal;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const KeyboardKey({
    Key? key,
    this.icon,
    this.backgroundColor = kGrey,
    this.onTap,
    required this.keyVal,
  }) : super(key: key);

  void onNormalKeyTap(BuildContext context) {
    context.read<Game>().addLetter(keyVal);
  }

  @override
  Widget build(BuildContext context) {
    final baseWidth = min(
      MediaQuery.of(context).size.width,
      kLayoutMaxWidth,
    );
    final keyWidth = (baseWidth - kDefaultPadding / 2) / keyRows[0].length - 4;
    final bool isNotVietnamese = {'w', 'f', 'j', 'z'}.contains(keyVal);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isNotVietnamese
              ? [kMediumGrey, darken(kMediumGrey, 0.2)]
              : [backgroundColor, darken(backgroundColor, 0.2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
          onTap: onTap ?? () => onNormalKeyTap(context),
          child: Container(
            alignment: Alignment.center,
            width:
                [enterKey, delKey].contains(keyVal) ? 1.5 * keyWidth : keyWidth,
            height: 1.4 * keyWidth,
            child: icon != null
                ? Icon(icon, size: 26, color: Colors.white)
                : Text(
                    keyVal,
                    style: TextStyle(fontSize: keyWidth * 0.5),
                  ),
          ),
        ),
      ),
    );
  }
}
