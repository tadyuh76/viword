import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viword/constants/breakpoints.dart';
import 'package:viword/constants/colors.dart';
import 'package:viword/providers/game_provider.dart';
import 'package:viword/utils/color_changer.dart';
import 'package:viword/utils/show_snack_bar.dart';

class EndDialog extends StatelessWidget {
  const EndDialog({Key? key}) : super(key: key);

  void createNewGame(BuildContext context) {
    Provider.of<Game>(context).reset();
    showSnackBar(
      context: context,
      backgroundColor: darken(kWrongAccentColor, 0.05),
      text: 'Đã khởi tạo từ mới',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(kDefaultPadding),
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: kLayoutMaxWidth),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: kCorrectColor,
            borderRadius: BorderRadius.circular(kDefaultPadding),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'ĐÚNG RỒI!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: kDefaultPadding),
                    _StatisticsItem(
                      text: 'Đáp án',
                      data: Provider.of<Game>(context, listen: false).solution,
                    ),
                    const SizedBox(height: kDefaultPadding / 2),
                    _StatisticsItem(
                      text: 'Số lượt đã đoán',
                      data: Provider.of<Game>(context, listen: false)
                          .currentIndex
                          .toString(),
                    ),
                  ],
                ),
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(color: darken(kCorrectColor)),
                child: Row(
                  children: [
                    _CustomIconButton(
                      icon: Icons.arrow_back_rounded,
                      text: 'Trở về',
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    _CustomIconButton(
                      icon: Icons.repeat_rounded,
                      text: 'Chơi lại',
                      onTap: () {
                        Navigator.of(context).pop();
                        createNewGame(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatisticsItem extends StatelessWidget {
  final String text;
  final String data;

  const _StatisticsItem({
    Key? key,
    required this.text,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          Text(
            data.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomIconButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _CustomIconButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 30),
              Text(
                ' $text',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 14,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
