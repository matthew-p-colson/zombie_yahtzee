import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zombie_yahtzee/logic/letter_logic.dart';
import 'package:zombie_yahtzee/logic/screen_size_logic.dart';
import 'package:zombie_yahtzee/logic/state_logic.dart';
import 'package:zombie_yahtzee/screens/style.dart';

class ZombieScreen extends StatefulWidget {
  const ZombieScreen({Key? key}) : super(key: key);

  @override
  State<ZombieScreen> createState() => _ZombieScreenState();
}

class _ZombieScreenState extends State<ZombieScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenSizeLogic.init(context);
    return Scaffold(
      backgroundColor: Styles.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Styles.kContainerColor,
        centerTitle: true,
        title: LetterLogic.getLetters(
          letters: 'Zombie Yahtzee',
          letterColor: LetterColor.tan,
          letterHeight: ScreenSizeLogic.blockSizeVertical * 2.5,
          letterSpacing: ScreenSizeLogic.blockSizeVertical * .5,
          wordSpacing: ScreenSizeLogic.blockSizeVertical,
          alignment: MainAxisAlignment.center,
        ),
        actions: [
          PopupMenuButton(
              onSelected: (value) {
                switch (value) {
                  case 0:
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/game", (r) => false);
                    break;
                  case 1:
                    Navigator.pushNamed(context, '/high_score');
                    break;
                  case 2:
                    SystemNavigator.pop();
                    break;
                }
              },
              color: Styles.kContainerColor,
              iconSize: ScreenSizeLogic.blockSizeVertical * 4,
              icon: const Icon(
                Icons.more_vert,
                color: Styles.kTextColor,
              ),
              itemBuilder: (context) {
                return [
                  buildActionPopupMenuItem(0, 'New Game'),
                  buildActionPopupMenuItem(1, 'High Score'),
                  buildActionPopupMenuItem(2, 'Quit'),
                ];
              }),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Styles.kContainerColor,
            border: Border.all(
              color: Styles.kBorderColor,
              width: ScreenSizeLogic.blockSizeVertical * .5,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(ScreenSizeLogic.blockSizeVertical * 2),
            ),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black,
                  blurRadius: 6.0,
                  offset: Offset(0.0, 1.0)),
            ]),
        margin: EdgeInsets.all(ScreenSizeLogic.blockSizeVertical),
        padding: EdgeInsets.all(ScreenSizeLogic.blockSizeVertical),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LetterLogic.getLetters(
              letters: 'Game Over',
              letterColor: LetterColor.red,
              letterHeight: ScreenSizeLogic.blockSizeVertical * 5,
              letterSpacing: ScreenSizeLogic.blockSizeVertical * .5,
              wordSpacing: ScreenSizeLogic.blockSizeVertical,
              alignment: MainAxisAlignment.center,
            ),
            Image.asset(
              'images/logos/logo.png',
              height: ScreenSizeLogic.blockSizeVertical * 30,
            ),
            Column(
              children: [
                LetterLogic.getLetters(
                  letters: 'Too many zombies',
                  letterColor: LetterColor.red,
                  letterHeight: ScreenSizeLogic.blockSizeVertical * 2,
                  letterSpacing: ScreenSizeLogic.blockSizeVertical * .5,
                  wordSpacing: ScreenSizeLogic.blockSizeVertical,
                  alignment: MainAxisAlignment.center,
                ),
                SizedBox(
                  height: ScreenSizeLogic.blockSizeVertical,
                ),
                LetterLogic.getLetters(
                  letters: 'Got though and now',
                  letterColor: LetterColor.red,
                  letterHeight: ScreenSizeLogic.blockSizeVertical * 2,
                  letterSpacing: ScreenSizeLogic.blockSizeVertical * .5,
                  wordSpacing: ScreenSizeLogic.blockSizeVertical,
                  alignment: MainAxisAlignment.center,
                ),
                SizedBox(
                  height: ScreenSizeLogic.blockSizeVertical,
                ),
                LetterLogic.getLetters(
                  letters: 'your dead',
                  letterColor: LetterColor.red,
                  letterHeight: ScreenSizeLogic.blockSizeVertical * 2,
                  letterSpacing: ScreenSizeLogic.blockSizeVertical * .5,
                  wordSpacing: ScreenSizeLogic.blockSizeVertical,
                  alignment: MainAxisAlignment.center,
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                StateLogic.restartGame();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/game', (route) => false);
              },
              child: LetterLogic.getLetters(
                letters: 'Play Again',
                letterColor: LetterColor.tan,
                letterHeight: ScreenSizeLogic.blockSizeVertical * 4,
                letterSpacing: ScreenSizeLogic.blockSizeVertical * .5,
                wordSpacing: ScreenSizeLogic.blockSizeVertical,
                alignment: MainAxisAlignment.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<int> buildActionPopupMenuItem(int value, String text) {
    return PopupMenuItem(
      value: value,
      child: LetterLogic.getLetters(
        letters: text,
        letterColor: LetterColor.tan,
        letterHeight: ScreenSizeLogic.blockSizeVertical * 2,
        letterSpacing: ScreenSizeLogic.blockSizeVertical * .5,
        wordSpacing: ScreenSizeLogic.blockSizeVertical,
        alignment: MainAxisAlignment.start,
      ),
    );
  }
}
