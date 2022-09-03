import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viword/constants/breakpoints.dart';
import 'package:viword/providers/game_provider.dart';
import 'package:viword/screens/game_screen/custom_app_bar.dart';
import 'package:viword/widgets/game/accent_box.dart';
import 'package:viword/widgets/game/board.dart';
import 'package:viword/widgets/keyboard/keyboard.dart';
import 'package:viword/widgets/screen_background.dart';

class GameScreen extends StatefulWidget {
  static const routeName = '/game';
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<Game>().initGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<Game>().hideAccentBox(),
      child: Scaffold(
        appBar: renderAppBar(context),
        body: ScreenBackground(
          child: Stack(
            children: [
              Column(
                children: const [
                  SizedBox(height: kDefaultPadding / 2),
                  Board(),
                  SizedBox(height: kDefaultPadding / 2),
                  Keyboard(),
                  SizedBox(height: kDefaultPadding / 2),
                ],
              ),
              const AccentBox(),
            ],
          ),
        ),
      ),
    );
  }
}
