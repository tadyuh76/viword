import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viword/constants/colors.dart';
import 'package:viword/constants/game.dart';
import 'package:viword/providers/game_provider.dart';
import 'package:viword/screens/home_screen/home_screen.dart';
import 'package:viword/utils/color_changer.dart';
import 'package:viword/utils/show_snack_bar.dart';
import 'package:viword/widgets/dialogs/exit_dialog.dart';
import 'package:viword/widgets/dialogs/tutorial_dialog.dart';

AppBar renderAppBar(BuildContext context) {
  displayBackDialog() {
    showDialog(
      context: context,
      builder: (context) => ExitDialog(
        title: 'Bạn có chắc chắn muốn thoát?',
        subtitle: 'Tiến độ trò chơi sẽ được lưu lại',
        onTap: () => Navigator.of(context).popUntil(
          ModalRoute.withName(HomeScreen.routeName),
        ),
      ),
    );
  }

  renderBackButton() {
    return WillPopScope(
      onWillPop: () async {
        displayBackDialog();
        return false;
      },
      child: _AppBarButton(
        icon: Icons.chevron_left,
        iconSize: 32,
        onTap: displayBackDialog,
      ),
    );
  }

  renderResetButton() {
    return _AppBarButton(
      icon: Icons.repeat,
      iconSize: 22,
      onTap: () => showDialog(
        context: context,
        builder: (context) => ExitDialog(
          title: 'Bạn có chắc chắn muốn chơi lại?',
          subtitle: 'Tiến độ trò chơi sẽ được làm mới',
          onTap: () {
            context.read<Game>().reset();
            context.read<Game>().cache();

            Navigator.of(context).pop();

            showSnackBar(
              context: context,
              backgroundColor: darken(kWrongAccentColor, 0.05),
              text: 'Đã khởi tạo ViWord mới!',
            );
          },
        ),
      ),
    );
  }

  renderTutorialButton() {
    return _AppBarButton(
      icon: Icons.question_mark_rounded,
      iconSize: 24,
      onTap: () => showDialog(
        context: context,
        barrierColor: kBackground.withOpacity(0.3),
        builder: (context) => const TutorialDialog(),
      ),
    );
  }

  return AppBar(
    backgroundColor: kBackground,
    elevation: 3,
    centerTitle: true,
    title: const Text(appName),
    titleTextStyle: const TextStyle(
      fontSize: 28,
      fontFamily: 'Beon',
      letterSpacing: 4,
      color: kPurple,
      shadows: [Shadow(color: kPurple, blurRadius: 4)],
    ),
    leading: renderBackButton(),
    actions: [
      renderResetButton(),
      renderTutorialButton(),
    ],
  );
}

class _AppBarButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double iconSize;

  const _AppBarButton({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onTap,
        child: Container(
          width: 50,
          height: 50,
          alignment: Alignment.center,
          child: Icon(
            icon,
            color: kGrey,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
