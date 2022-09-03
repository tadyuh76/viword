import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:viword/constants/colors.dart';
import 'package:viword/constants/game.dart';
import 'package:viword/models/letter.dart';
import 'package:viword/models/word.dart';
import 'package:viword/providers/game_provider.dart';
import 'package:viword/screens/game_mode_screen/game_mode_screen.dart';
import 'package:viword/screens/game_screen/game_screen.dart';
import 'package:viword/screens/home_screen/home_screen.dart';
import 'package:viword/utils/enums.dart';
import 'package:viword/widgets/max_width_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(LetterAdapter());
  Hive.registerAdapter(LetterStatusAdapter());
  Hive.registerAdapter(WordAdapter());
  Hive.registerAdapter(GameStatusAdapter());
  await Hive.openBox('gameData');

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Game())],
      child: const MaxWidthContainer(child: App()),
    ),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ViWord',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, fontFamily: kDefaultFont)
          .copyWith(scaffoldBackgroundColor: kBackground),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        GameModeScreen.routeName: (context) => const GameModeScreen(),
        GameScreen.routeName: (context) => const GameScreen(),
      },
      builder: (context, child) {
        return MediaQuery(
          // force the font size not to change
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
    );
  }
}
