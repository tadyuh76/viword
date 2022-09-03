import 'package:flutter/material.dart';
import 'package:viword/constants/breakpoints.dart';
import 'package:viword/constants/colors.dart';

class GameModeButton extends StatefulWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const GameModeButton({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  State<GameModeButton> createState() => _GameModeButtonState();
}

class _GameModeButtonState extends State<GameModeButton> {
  bool isHover = false;

  void enableHoverEffect(bool val) => setState(() => isHover = val);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: 280,
      height: 80,
      clipBehavior: Clip.none,
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      decoration: BoxDecoration(
        color: isHover ? kPurple : kBackground,
        border: Border.all(color: kPurple),
        borderRadius: BorderRadius.circular(kDefaultPadding),
        boxShadow: const [BoxShadow(color: kPurple, blurRadius: 4)],
      ),
      child: InkWell(
        onTap: widget.onTap,
        onHover: enableHoverEffect,
        onHighlightChanged: enableHoverEffect,
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.subtitle,
                  style: const TextStyle(
                    color: kGrey,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            alignment: Alignment.center,
            child: Icon(
              Icons.chevron_right,
              color: isHover ? kGrey : kMediumGrey,
              size: 32,
            ),
          )
        ]),
      ),
    );
  }
}
