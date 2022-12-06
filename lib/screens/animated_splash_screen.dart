import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:zombie_yahtzee/logic/letter_logic.dart';
import 'package:zombie_yahtzee/logic/screen_size_logic.dart';
import 'package:zombie_yahtzee/screens/start_screen.dart';
import 'package:zombie_yahtzee/screens/style.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSizeLogic.init(context);
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          LetterLogic.getLetters(
              letters: 'Zombie Yahtzee',
              letterColor: LetterColor.tan,
              letterHeight: ScreenSizeLogic.blockSizeVertical * 3,
              letterSpacing: ScreenSizeLogic.blockSizeVertical * .5,
              wordSpacing: ScreenSizeLogic.blockSizeVertical,
              alignment: MainAxisAlignment.center),
          SizedBox(
            height: ScreenSizeLogic.blockSizeVertical * 2,
          ),
          Image.asset(
            'images/logos/logo.png',
            height: ScreenSizeLogic.blockSizeVertical * 10,
          ),
        ],
      ),
      splashIconSize: ScreenSizeLogic.blockSizeVertical * 20,
      splashTransition: SplashTransition.fadeTransition,
      duration: 3000,
      backgroundColor: Styles.kContainerColor,
      nextScreen: const StartScreen(),
      nextRoute: '/',
    );
  }
}
