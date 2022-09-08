import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:viword/constants/game.dart';
import 'package:viword/models/letter.dart';
import 'package:viword/models/word.dart';
import 'package:viword/services/cache_service.dart';
import 'package:viword/services/game_service.dart';
import 'package:viword/utils/enums.dart';
import 'package:viword/utils/remove_diacritics.dart';

class Game extends ChangeNotifier {
  final _flipCardControllers = GameService().initFlipCardControllers;
  var _solution = GameService().getWordOfTheDay();
  var _board = GameService().initBoard;
  var _currentIndex = 0;
  var _gameStatus = GameStatus.playing;
  var _accentBoxVisible = false;
  List<Letter> _specialKeys = [];

  List<List<FlipCardController>> get flipCardControllers =>
      _flipCardControllers;
  String get solution => _solution;
  List<Word> get board => _board;
  GameStatus get gameStatus => _gameStatus;
  bool get accentBoxVisible => _accentBoxVisible;
  int get currentIndex => _currentIndex;
  List<Letter> get specialKeys => _specialKeys;

  Word? get currentWord =>
      _currentIndex < _board.length ? _board[_currentIndex] : null;
  bool get isNotPlaying => gameStatus != GameStatus.playing;

  void initGame() {
    final box = Hive.box('gameData');

    try {
      _board = box.get('board', defaultValue: _board).cast<Word>();
      _specialKeys = box.get('specialKeys', defaultValue: []).cast<Letter>();
      _currentIndex = box.get('currentIndex', defaultValue: currentIndex);
      _gameStatus = box.get('gameStatus', defaultValue: gameStatus);
      _solution = box.get('solution', defaultValue: solution);

      flipAllRows();
      notifyListeners();
    } catch (e) {
      print('Error initializing game: $e');
    }
  }

  void cache() {
    CacheService().cacheGameData(
      board: _board,
      solution: _solution,
      currentIndex: _currentIndex,
      gameStatus: _gameStatus,
      specialKeys: _specialKeys,
    );
  }

  void updateStatus(GameStatus newGameStatus) {
    _gameStatus = newGameStatus;
    notifyListeners();
  }

  void hideAccentBox() {
    _accentBoxVisible = false;
    notifyListeners();
  }

  void nextIndex() {
    _currentIndex++;
    notifyListeners();
  }

  void addLetter(String key) {
    if (isNotPlaying) return;

    bool added = currentWord?.addLetter(key) ?? false;
    if (added & keyWithAccents.containsKey(key)) {
      _accentBoxVisible = true;
    }
    notifyListeners();
  }

  void addAccent(String newValWithAccent) {
    currentWord!
      ..removeLetter()
      ..addLetter(newValWithAccent);

    notifyListeners();
  }

  void deleteLetter() {
    if (isNotPlaying) return;

    currentWord?.removeLetter();
    notifyListeners();
  }

  void updateKeyboard() {
    for (Letter letter in currentWord!.letters) {
      final removedAccentLetterVal = removeDiacritics(letter.val);
      final currentSavedKey = _specialKeys.firstWhere(
          (e) => e.val == removedAccentLetterVal,
          orElse: () => Letter.empty());

      if (statusPriority[letter.status]! >
          statusPriority[currentSavedKey.status]!) {
        _specialKeys.removeWhere((e) => e.val == removedAccentLetterVal);
        _specialKeys.add(Letter(
          val: removedAccentLetterVal,
          status: letter.status,
        ));
      }
    }
    notifyListeners();
  }

  String boardToEmojis() {
    return _board
        .map((word) {
          final emojisLine = word.letters
              .map((letter) => statusToEmojis[letter.status])
              .toList()
              .join();
          return emojisLine;
        })
        .toList()
        .where((line) => line.isNotEmpty)
        .join("\n");
  }

  void flipOneRow(int rowIndex) {
    final curRow = _flipCardControllers[rowIndex];

    curRow.asMap().forEach((i, controller) {
      Future.delayed(
        Duration(milliseconds: i * 150),
        () => controller.toggleCard(),
      );
    });
  }

  void flipAllRows() {
    for (int i = 0; i < currentIndex; i++) {
      flipOneRow(i);
    }
  }

  void resetFlipCards() {
    for (final row in _flipCardControllers) {
      for (final controller in row) {
        controller.controller?.reset();
      }
    }
  }

  void reset() {
    _solution = GameService().getWordOfTheDay();
    _board = GameService().initBoard;
    _specialKeys = [];
    _currentIndex = 0;
    _gameStatus = GameStatus.playing;

    resetFlipCards();
    notifyListeners();
  }
}
