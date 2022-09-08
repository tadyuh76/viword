import 'dart:math';

import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:viword/constants/game.dart';
import 'package:viword/models/letter.dart';
import 'package:viword/models/word.dart';
import 'package:viword/resources/solutions.dart';
import 'package:viword/resources/words.dart';
import 'package:viword/utils/enums.dart';
import 'package:viword/utils/remove_diacritics.dart';

class GameService {
  List<Word> get initBoard => List.generate(
        numberOfGuess,
        (_) => Word(letters: List.generate(6, (_) => Letter.empty())),
      );

  List<List<FlipCardController>> get initFlipCardControllers => List.generate(
        numberOfGuess,
        (_) => List.generate(6, (_) => FlipCardController()),
      );

  String getNewSolution() {
    final randomIdx = Random().nextInt(solutions.length);
    debugPrint('Solution is: ${solutions[randomIdx]}');
    return solutions[randomIdx];
  }

  bool dictionaryHas(Word word) {
    return words.contains(word.wordString());
  }

  bool validate(Word currentWord, String solution) {
    int correct = 0;
    final letters = currentWord.letters;
    String remainToCheck = solution;

    // check for correct and wrong accent keys
    for (int i = 0; i < letters.length; i++) {
      final Letter letter = letters[i];
      final String solutionVal = solution[i];

      bool isCorrect = letter.val == solutionVal;
      bool isWrongAccent =
          removeDiacritics(solutionVal) == removeDiacritics(letter.val);

      if (isCorrect) {
        correct++;
        remainToCheck = remainToCheck.replaceFirst(remainToCheck[i], ' ', i);
        letter.copyWith(status: LetterStatus.correct);
      } else if (isWrongAccent) {
        remainToCheck = remainToCheck.replaceFirst(remainToCheck[i], ' ', i);
        letter.copyWith(status: LetterStatus.wrongAccent);
      } else {
        letter.copyWith(status: LetterStatus.notInWord);
      }
    }

    // check for wrong position keys
    for (int i = 0; i < letters.length; i++) {
      final Letter curLetter = letters[i];
      final String rdLetterVal = removeDiacritics(curLetter.val);
      final String curSolLetter = solution[i];

      bool isCorrect = curLetter.val == curSolLetter;
      bool isWrongAccent = removeDiacritics(curSolLetter) == rdLetterVal;
      bool isWrongPosition =
          removeDiacritics(remainToCheck).contains(rdLetterVal);

      if (isWrongPosition && !isCorrect && !isWrongAccent) {
        final indexToReplace =
            removeDiacritics(remainToCheck).indexOf(rdLetterVal);

        remainToCheck =
            remainToCheck.replaceFirst(remainToCheck[indexToReplace], ' ');
        curLetter.copyWith(status: LetterStatus.wrongPosition);
      }
    }

    return correct == letters.length;
  }
}
