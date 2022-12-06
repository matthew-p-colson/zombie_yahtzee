import 'package:flutter/material.dart';
import 'package:zombie_yahtzee/logic/dice_logic.dart';
import 'package:zombie_yahtzee/logic/high_score_logic.dart';
import 'package:zombie_yahtzee/logic/letter_logic.dart';
import 'package:zombie_yahtzee/logic/number_logic.dart';
import 'package:zombie_yahtzee/logic/scorecard_logic.dart';
import 'package:zombie_yahtzee/logic/undo_logic.dart';
import 'package:zombie_yahtzee/logic/zombie_logic.dart';
import 'package:zombie_yahtzee/models/game_state.dart';
import 'package:zombie_yahtzee/screens/animated_splash_screen.dart';
import 'package:zombie_yahtzee/screens/game_screen.dart';
import 'package:zombie_yahtzee/screens/high_score_screen.dart';
import 'package:zombie_yahtzee/screens/new_high_score_screen.dart';
import 'package:zombie_yahtzee/screens/start_screen.dart';
import 'package:zombie_yahtzee/screens/zombie_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CurrentState.init();
  PastState.init();
  HighScoreLogic.init();
  LetterLogic.init();
  NumberLogic.init();
  DiceLogic.init();
  UndoLogic.init();
  ScorecardLogic.init();
  ZombieLogic.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zombie Yahtzee',
      initialRoute: '/splash',
      routes: {
        '/': (context) => const StartScreen(),
        '/high_score': (context) => const HighScoreScreen(),
        '/game': (context) => const GameScreen(),
        '/zombie': (context) => const ZombieScreen(),
        '/new_high_score': (context) => const NewHighScoreScreen(),
        '/splash': (context) => const SplashScreen(),
      },
    );
  }
}
