import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:viword/constants/breakpoints.dart';
import 'package:viword/constants/colors.dart';
import 'package:viword/constants/game.dart';
import 'package:viword/models/letter.dart';
import 'package:viword/utils/enums.dart';
import 'package:viword/widgets/dialogs/custom_close_button.dart';
import 'package:viword/widgets/game/board_tile.dart';

class TutorialDialog extends StatelessWidget {
  const TutorialDialog({Key? key}) : super(key: key);

  final _normalStyle = const TextStyle(
    color: kGrey,
    fontFamily: kDefaultFont,
    fontSize: 18,
  );
  final _boldStyle = const TextStyle(
    color: kGrey,
    fontFamily: kDefaultFont,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(kDefaultPadding),
      child: Container(
        width: double.infinity,
        height: size.height * 0.95,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: kDarkGrey,
          borderRadius: BorderRadius.circular(kDefaultPadding),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  kDefaultPadding, kDefaultPadding, kDefaultPadding, 0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/notebook.svg',
                    width: 36,
                    height: 36,
                  ),
                  const SizedBox(width: kDefaultPadding),
                  const Text(
                    'HƯỚNG DẪN',
                    style: TextStyle(color: kGrey, fontSize: 20),
                  ),
                  const Spacer(),
                  const CustomCloseButton(),
                ],
              ),
            ),
            const Divider(color: kMediumGrey, height: kDefaultPadding),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Đoán từ ',
                              style: _normalStyle,
                            ),
                            TextSpan(
                              text: '$appName ',
                              style: _boldStyle,
                            ),
                            TextSpan(
                              text:
                                  'trong $numberOfGuess lượt thử.\n\nMỗi lượt đoán phải là một ',
                              style: _normalStyle,
                            ),
                            TextSpan(
                              text: 'từ có nghĩa gồm 6 chữ cái. ',
                              style: _boldStyle,
                            ),
                            TextSpan(
                              text: 'Từ này có thể chứa ',
                              style: _normalStyle,
                            ),
                            TextSpan(
                              text: 'một hoặc nhiều tiếng. ',
                              style: _boldStyle,
                            ),
                            TextSpan(
                              text:
                                  'Nhấn biểu tượng >> để kiểm tra từ bạn đoán đã đúng hay chưa.\n\nSau mỗi lượt đoán, màu của các ô chữ sẽ thay đổi để thể hiện độ chính xác của từ bạn đoán với đáp án.\n',
                              style: _normalStyle,
                            )
                          ],
                        ),
                      ),
                      Text('Ví dụ:', style: _boldStyle),
                      _WordRow(
                        letters: [
                          Letter(val: 'đ', status: LetterStatus.correct),
                          Letter(val: 'e'),
                          Letter(val: 'n'),
                          Letter(val: 't'),
                          Letter(val: 'ố'),
                          Letter(val: 'i')
                        ],
                        text1: 'Chữ',
                        text2: '"Đ"',
                        text3: 'có trong đáp án và đang ở đúng vị trí.',
                      ),
                      _WordRow(
                        letters: [
                          Letter(val: 'd'),
                          Letter(val: 'a', status: LetterStatus.wrongAccent),
                          Letter(val: 'd'),
                          Letter(val: 'i'),
                          Letter(val: 'ế'),
                          Letter(val: 't')
                        ],
                        text1: 'Chữ',
                        text2: '"A"',
                        text3:
                            'có trong đáp án và đang ở đúng vị trí nhưng mang sai dấu.',
                      ),
                      _WordRow(
                        letters: [
                          Letter(val: 'c'),
                          Letter(val: 'o'),
                          Letter(val: 'n'),
                          Letter(val: 'c'),
                          Letter(val: 'á', status: LetterStatus.wrongPosition),
                          Letter(val: 'o')
                        ],
                        text1: 'Chữ',
                        text2: '"A" (không xét dấu của chữ này)',
                        text3: 'có trong đáp án nhưng đang ở sai vị trí.',
                      ),
                      _WordRow(
                        letters: [
                          Letter(val: 'á', status: LetterStatus.notInWord),
                          Letter(val: 'o'),
                          Letter(val: 'b'),
                          Letter(val: 'a', status: LetterStatus.notInWord),
                          Letter(val: 'l'),
                          Letter(val: 'ỗ')
                        ],
                        text1: 'Chữ',
                        text2: '"A"',
                        text3: 'không có trong đáp án.',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WordRow extends StatelessWidget {
  final List<Letter> letters;
  final String text1;
  final String text2;
  final String text3;

  const _WordRow({
    Key? key,
    required this.letters,
    required this.text1,
    required this.text2,
    required this.text3,
  }) : super(key: key);

  final _normalStyle = const TextStyle(
    color: kGrey,
    fontSize: 18,
    fontFamily: kDefaultFont,
  );
  final _boldStyle = const TextStyle(
    color: kGrey,
    fontFamily: kDefaultFont,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final double letterSize =
        width > kLayoutMaxWidth ? 50 : (width - 6 * kDefaultPadding) / 6 - 8;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: letters
                .map((e) => BoardTile(letter: e, size: letterSize))
                .toList(),
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: text1,
                style: _normalStyle,
              ),
              TextSpan(
                text: ' $text2 ',
                style: _boldStyle,
              ),
              TextSpan(
                text: text3,
                style: _normalStyle,
              ),
            ],
          ),
        ),
        const SizedBox(height: kDefaultPadding),
      ],
    );
  }
}
