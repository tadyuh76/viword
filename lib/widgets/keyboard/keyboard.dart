import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viword/constants/breakpoints.dart';
import 'package:viword/constants/colors.dart';
import 'package:viword/constants/game.dart';
import 'package:viword/models/letter.dart';
import 'package:viword/providers/game_provider.dart';
import 'package:viword/widgets/keyboard/delete_key.dart';
import 'package:viword/widgets/keyboard/enter_key.dart';
import 'package:viword/widgets/keyboard/keyboard_key.dart';
import 'package:viword/widgets/keyboard/limited_key.dart';

class Keyboard extends StatelessWidget {
  const Keyboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final limitedKeys = {'w', 'f', 'j', 'z'};

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 4),
      child: Column(
        children: keyRows
            .map(
              (row) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: row.map((key) {
                  if (key == enterKey) {
                    return const EnterKey();
                  }
                  if (key == delKey) {
                    return const DeleteKey();
                  }
                  if (limitedKeys.contains(key)) {
                    return LimitedKey(keyVal: key);
                  }

                  Letter currentKey =
                      context.watch<Game>().specialKeys.firstWhere(
                            (e) => e.val == key,
                            orElse: () => Letter.empty(),
                          );

                  return KeyboardKey(
                    keyVal: key,
                    backgroundColor: currentKey.val == ''
                        ? kGrey
                        : currentKey.backgroundColor,
                  );
                }).toList(),
              ),
            )
            .toList(),
      ),
    );
  }
}
