import 'package:flutter/material.dart';
import 'package:zombie_yahtzee/logic/letter_logic.dart';
import 'package:zombie_yahtzee/logic/number_logic.dart';
import 'package:zombie_yahtzee/screens/start_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LetterLogic.init();
  NumberLogic.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zombie Yahtzee',
      initialRoute: '/',
      routes: {
        '/': (context) => const StartScreen(),
      },
    );
  }
}
