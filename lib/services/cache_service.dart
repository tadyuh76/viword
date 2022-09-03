import 'package:hive/hive.dart';
import 'package:viword/models/letter.dart';
import 'package:viword/models/word.dart';
import 'package:viword/utils/enums.dart';

class CacheService {
  void cacheGameData({
    required List<Word> board,
    required String solution,
    required int currentIndex,
    required GameStatus gameStatus,
    required List<Letter> specialKeys,
  }) async {
    try {
      final box = await Hive.openBox('gameData');
      await box.put('board', board);
      await box.put('solution', solution);
      await box.put('currentIndex', currentIndex);
      await box.put('gameStatus', gameStatus);
      await box.put('specialKeys', specialKeys);
    } catch (e) {
      print('Error putting data: $e');
    }
  }
}
