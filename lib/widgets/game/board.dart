import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viword/constants/breakpoints.dart';
import 'package:viword/models/letter.dart';
import 'package:viword/providers/game_provider.dart';
import 'package:viword/widgets/game/board_tile.dart';

class Board extends StatelessWidget {
  const Board({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Distribute BoardTile size based on the smallest screen's dimension
            final baseSize = min(
                min(constraints.maxHeight, constraints.maxWidth),
                kLayoutMaxWidth);

            // In case the available height is smallest, distribute board size for 7 tiles
            // Otherwise, distribute for 6 tiles (horizontal)
            final boardSize = baseSize == constraints.maxHeight
                ? (baseSize / 7) - 6
                : (baseSize / 6) - 6;

            return Consumer<Game>(
              builder: ((context, game, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: game.board
                        .asMap()
                        .map(
                          (i, word) => MapEntry(
                            i,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: word.letters
                                  .asMap()
                                  .map((j, letter) => MapEntry(
                                        j,
                                        FlipCard(
                                          controller:
                                              game.flipCardControllers[i][j],
                                          flipOnTouch: false,
                                          front: BoardTile(
                                            letter: Letter(val: letter.val),
                                            size: boardSize,
                                          ),
                                          back: BoardTile(
                                            letter: letter,
                                            size: boardSize,
                                          ),
                                        ),
                                      ))
                                  .values
                                  .toList(),
                            ),
                          ),
                        )
                        .values
                        .toList(),
                  )),
            );
          },
        ),
      ),
    );
  }
}
