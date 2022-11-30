import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zombie_yahtzee/logic/letter_logic.dart';
import 'package:zombie_yahtzee/logic/screen_size_logic.dart';
import 'package:zombie_yahtzee/screens/style.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(ScreenSizeLogic.blockSizeVertical * 2),
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
              child: Image.asset(
                'images/logos/logo.png',
                height: ScreenSizeLogic.blockSizeVertical * 30,
              ),
            ),
            SizedBox(
              height: ScreenSizeLogic.blockSizeVertical * 8,
            ),
            Container(
              margin: EdgeInsets.only(
                  left: ScreenSizeLogic.blockSizeVertical * 2,
                  right: ScreenSizeLogic.blockSizeVertical * 2),
              padding: EdgeInsets.only(
                  top: ScreenSizeLogic.blockSizeVertical * 2,
                  bottom: ScreenSizeLogic.blockSizeVertical * 2),
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
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/game", (r) => false);
                    },
                    child: LetterLogic.getLetters(
                        letters: 'New Game',
                        letterColor: LetterColor.green,
                        letterHeight: ScreenSizeLogic.blockSizeVertical * 4,
                        letterSpacing: ScreenSizeLogic.blockSizeVertical * .5,
                        wordSpacing: ScreenSizeLogic.blockSizeVertical,
                        alignment: MainAxisAlignment.center),
                  ),
                  SizedBox(
                    height: ScreenSizeLogic.blockSizeVertical * 2,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/high_score');
                    },
                    child: LetterLogic.getLetters(
                      letters: 'High Score',
                      letterColor: LetterColor.green,
                      letterHeight: ScreenSizeLogic.blockSizeVertical * 4,
                      letterSpacing: ScreenSizeLogic.blockSizeVertical * .5,
                      wordSpacing: ScreenSizeLogic.blockSizeVertical,
                      alignment: MainAxisAlignment.center,
                    ),
                  ),
                  SizedBox(
                    height: ScreenSizeLogic.blockSizeVertical * 2,
                  ),
                  TextButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: LetterLogic.getLetters(
                      letters: 'Quit',
                      letterColor: LetterColor.red,
                      letterHeight: ScreenSizeLogic.blockSizeVertical * 4,
                      letterSpacing: ScreenSizeLogic.blockSizeVertical * .5,
                      wordSpacing: ScreenSizeLogic.blockSizeVertical,
                      alignment: MainAxisAlignment.center,
                    ),
                  ),
                ],
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
