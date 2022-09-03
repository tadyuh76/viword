import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viword/constants/colors.dart';
import 'package:viword/constants/game.dart';
import 'package:viword/providers/game_provider.dart';
import 'package:viword/services/game_service.dart';
import 'package:viword/utils/enums.dart';
import 'package:viword/utils/show_snack_bar.dart';
import 'package:viword/widgets/dialogs/end_dialog.dart';
import 'package:viword/widgets/keyboard/keyboard_key.dart';

class EnterKey extends StatelessWidget {
  const EnterKey({Key? key}) : super(key: key);

  void onTap(BuildContext context) {
    final game = context.read<Game>();
    final currentWord = game.currentWord;
    final currentIndex = game.currentIndex;
    final board = game.board;
    final solution = game.solution;

    if (game.isNotPlaying) return;

    final isNotFullWord =
        currentWord == null || currentWord.letters.any((e) => e.val == '');
    if (isNotFullWord) {
      return showSnackBar(
        context: context,
        backgroundColor: kRed,
        text: 'Bạn chưa nhập hết từ!',
      );
    }

    bool inDictionary = GameService().dictionaryHas(currentWord);
    if (!inDictionary) {
      return showSnackBar(
        context: context,
        backgroundColor: kRed,
        text: 'Từ này không có trong danh sách!',
      );
    }

    game.updateStatus(GameStatus.submitting);

    bool isCorrect = GameService().validate(currentWord, solution);
    bool isLost = currentIndex == board.length;

    if (isCorrect) {
      handleWon(context);
      game.updateStatus(GameStatus.won);
    } else if (isLost) {
      handleLost(context, solution);
      game.updateStatus(GameStatus.lost);
    } else {
      game.updateStatus(GameStatus.playing);
    }

    game.updateKeyboard();
    game.flipOneRow(currentIndex);
    game.nextIndex();
    game.cache();
  }

  void handleWon(BuildContext context) {
    Future.delayed(
      const Duration(milliseconds: 1500),
      () => showDialog(
        context: context,
        builder: (_) => const EndDialog(),
      ),
    );
  }

  void handleLost(BuildContext context, String solution) {
    showSnackBar(
      context: context,
      backgroundColor: kRed,
      text: 'Từ của ngày hôm nay là $solution',
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardKey(
      keyVal: enterKey,
      onTap: () => onTap(context),
      icon: Icons.keyboard_double_arrow_right,
      backgroundColor: kMediumGrey,
    );
  }
}
