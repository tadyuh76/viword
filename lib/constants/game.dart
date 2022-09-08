import 'package:flip_card/flip_card_controller.dart';
import 'package:viword/models/letter.dart';
import 'package:viword/models/word.dart';
import 'package:viword/utils/enums.dart';

const appName = 'ViWord';
const numberOfGuess = 7;
const kDefaultFont = 'Quicksand';

const enterKey = 'enter';
const delKey = 'del';
const keyRows = [
  ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'],
  ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'],
  [delKey, 'z', 'x', 'c', 'v', 'b', 'n', 'm', enterKey],
];

const keyWithAccents = {
  'a': [
    ['', 'á', 'à', 'ả', 'ã', 'ạ'],
    ['â', 'ấ', 'ầ', 'ẩ', 'ẫ', 'ậ'],
    ['ă', 'ắ', 'ằ', 'ẳ', 'ẵ', 'ặ'],
  ],
  'e': [
    ['', 'é', 'è', 'ẻ', 'ẽ', 'ẹ'],
    ['ê', 'ế', 'ề', 'ể', 'ễ', 'ệ'],
  ],
  'i': [
    ['í', 'ì', 'ỉ', 'ĩ', 'ị'],
  ],
  'o': [
    ['', 'ó', 'ò', 'ỏ', 'õ', 'ọ'],
    ['ô', 'ố', 'ồ', 'ổ', 'ỗ', 'ộ'],
    ['ơ', 'ớ', 'ờ', 'ở', 'ỡ', 'ợ'],
  ],
  'u': [
    ['', 'ú', 'ù', 'ủ', 'ũ', 'ụ'],
    ['ư', 'ứ', 'ừ', 'ử', 'ữ', 'ự'],
  ],
  'y': [
    ['ý', 'ỳ', 'ỷ', 'ỹ', 'ỵ']
  ],
  'd': [
    ['đ']
  ]
};

const statusPriority = {
  LetterStatus.initial: 0,
  LetterStatus.notInWord: 1,
  LetterStatus.wrongPosition: 2,
  LetterStatus.wrongAccent: 3,
  LetterStatus.correct: 4,
};

final statusToEmojis = {
  LetterStatus.correct: "🟩",
  LetterStatus.wrongAccent: "🟦",
  LetterStatus.wrongPosition: "🟧",
  LetterStatus.notInWord: "⬛",
  LetterStatus.initial: ""
};

final initBoard = List.generate(
  numberOfGuess,
  (_) => Word(letters: List.generate(6, (_) => Letter.empty())),
);

final initFlipCardControllers = List.generate(
  numberOfGuess,
  (_) => List.generate(6, (_) => FlipCardController()),
);
