import 'dart:math';
import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:provider/provider.dart';
import 'package:viword/constants/breakpoints.dart';
import 'package:viword/constants/colors.dart';
import 'package:viword/constants/game.dart';
import 'package:viword/models/letter.dart';
import 'package:viword/providers/game_provider.dart';
import 'package:viword/widgets/game/accent_key.dart';

class AccentBox extends StatelessWidget {
  const AccentBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseSize = min(MediaQuery.of(context).size.width, kLayoutMaxWidth);
    final keyHeight = (baseSize / 10) * 1.4;
    final keyboardHeight = keyHeight * 3;

    final currentWord = context.watch<Game>().currentWord;
    final Letter lastLetter =
        currentWord != null ? currentWord.lastLetter : Letter.empty();
    final accentedKeys = keyWithAccents[lastLetter.val];

    if (accentedKeys == null) {
      return const SizedBox.shrink();
    }

    return Consumer<Game>(
      builder: (context, game, child) => Visibility(
        visible: game.accentBoxVisible,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: keyboardHeight + kDefaultPadding,
              child: Container(
                width: 284,
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                decoration: BoxDecoration(
                  color: kDarkGrey,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 8,
                      color: kBackground,
                    ),
                  ],
                ),
                child: Column(
                  children: accentedKeys
                      .map((keyRow) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: keyRow
                                .map(
                                  (key) => accentedKeys.length == 1 && key == ''
                                      ? const SizedBox.shrink()
                                      : AccentKey(accentedKey: key),
                                )
                                .toList(),
                          ))
                      .toList(),
                ),
              ),
            ),
            Positioned(
              bottom: keyboardHeight + kDefaultPadding - 8,
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(1 / 8),
                child: Container(
                  width: 16,
                  height: 16,
                  color: kDarkGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
