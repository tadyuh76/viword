import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viword/constants/colors.dart';
import 'package:viword/providers/game_provider.dart';

class AccentKey extends StatelessWidget {
  final String accentedKey;
  const AccentKey({
    Key? key,
    required this.accentedKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isEmptyAccent = accentedKey == '';

    return isEmptyAccent
        ? const Padding(
            padding: EdgeInsets.all(2),
            child: SizedBox(width: 40, height: 40),
          )
        : Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: kMediumGrey,
              borderRadius: BorderRadius.circular(4),
            ),
            width: 40,
            height: 40,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => context.read<Game>().addAccent(accentedKey),
                child: Center(
                  child: Text(
                    accentedKey,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
