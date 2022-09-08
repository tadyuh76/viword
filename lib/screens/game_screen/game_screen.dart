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
  bool showMenu = false;

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
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: CustomAppBar(
            showMenu: showMenu,
            displayMenu: () => setState(() {
              showMenu = !showMenu;
            }),
          ),
        ),
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
              // MenuDropList(showMenu: showMenu),
              const AccentBox(),
            ],
          ),
        ),
      ),
    );
  }
}

// class MenuDropList extends StatelessWidget {
//   const MenuDropList({
//     Key? key,
//     required this.showMenu,
//   }) : super(key: key);

//   final bool showMenu;

//   @override
//   Widget build(BuildContext context) {
//     return Visibility(
//       visible: showMenu,
//       child: Positioned(
//         right: 0,
//         top: 0,
//         child: Container(
//           width: 160,
//           decoration: const BoxDecoration(
//             color: kDarkGrey,
//             borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
//           ),
//           child: Container(
//             height: 50,
//             padding: const EdgeInsets.all(kDefaultPadding / 2),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Chơi lại',
//                   style: TextStyle(fontSize: 16, color: kGrey),
//                 ),
//                 Icon(Icons.replay),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
