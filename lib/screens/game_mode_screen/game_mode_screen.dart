import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:viword/constants/breakpoints.dart';
import 'package:viword/constants/colors.dart';
import 'package:viword/screens/game_mode_screen/game_mode_button.dart';
import 'package:viword/screens/game_screen/game_screen.dart';

class GameModeScreen extends StatelessWidget {
  static const routeName = '/gamemode';
  const GameModeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Lottie.asset(
                    'assets/game_console.json',
                    width: 160,
                    height: 160,
                  ),
                  const Text(
                    'Chọn chế độ chơi',
                    style: TextStyle(color: kGrey, fontSize: 24),
                  ),
                  const SizedBox(height: kDefaultPadding * 2),
                  GameModeButton(
                    title: 'Cổ điển',
                    subtitle: 'Một người chơi',
                    onTap: () => Navigator.of(context)
                        .pushReplacementNamed(GameScreen.routeName),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  GameModeButton(
                    title: 'Online',
                    subtitle: 'Sắp ra mắt...',
                    disable: true,
                    onTap: () => Navigator.of(context)
                        .pushReplacementNamed(GameScreen.routeName),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Positioned(
              top: kDefaultPadding,
              left: kDefaultPadding,
              child: InkWell(
                onTap: Navigator.of(context).pop,
                borderRadius: BorderRadius.circular(50),
                child: const SizedBox(
                  width: 50,
                  height: 50,
                  child: Icon(Icons.chevron_left, size: 32),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
