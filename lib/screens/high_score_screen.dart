import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zombie_yahtzee/logic/high_score_logic.dart';
import 'package:zombie_yahtzee/logic/letter_logic.dart';
import 'package:zombie_yahtzee/logic/number_logic.dart';
import 'package:zombie_yahtzee/logic/screen_size_logic.dart';
import 'package:zombie_yahtzee/screens/style.dart';

class HighScoreScreen extends StatefulWidget {
  const HighScoreScreen({Key? key}) : super(key: key);

  @override
  State<HighScoreScreen> createState() => _HighScoreScreenState();
}

class _HighScoreScreenState extends State<HighScoreScreen> {
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
                    Navigator.pushNamed(context, '/game');
                    break;
                  case 1:
                    Navigator.pop(context);
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
                  buildActionPopupMenuItem(1, 'Back'),
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
            Container(
              padding: EdgeInsets.all(ScreenSizeLogic.blockSizeVertical * 2),
              margin: EdgeInsets.all(ScreenSizeLogic.blockSizeVertical),
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
              child: LetterLogic.getLetters(
                letters: 'High Scores',
                letterColor: LetterColor.tan,
                letterHeight: ScreenSizeLogic.blockSizeVertical * 3,
                letterSpacing: ScreenSizeLogic.blockSizeVertical * .5,
                wordSpacing: ScreenSizeLogic.blockSizeVertical,
                alignment: MainAxisAlignment.center,
              ),
            ),
            buildScoreContainer(1),
            buildScoreContainer(2),
            buildScoreContainer(3),
            buildScoreContainer(4),
            buildScoreContainer(5),
            buildScoreContainer(6),
            buildScoreContainer(7),
            buildScoreContainer(8),
            buildScoreContainer(9),
            buildScoreContainer(10),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: LetterLogic.getLetters(
                letters: 'Back',
                letterColor: LetterColor.tan,
                letterHeight: ScreenSizeLogic.blockSizeVertical * 2,
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

  Container buildScoreContainer(int place) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        ScreenSizeLogic.blockSizeVertical * 3,
        ScreenSizeLogic.blockSizeVertical,
        ScreenSizeLogic.blockSizeVertical * 3,
        ScreenSizeLogic.blockSizeVertical,
      ),
      margin: EdgeInsets.only(
          left: ScreenSizeLogic.blockSizeVertical,
          right: ScreenSizeLogic.blockSizeVertical),
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
                color: Colors.black, blurRadius: 6.0, offset: Offset(0.0, 1.0)),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NumberLogic.getNumbers(
            numbers: place,
            numberColor: NumberColor.tan,
            numberHeight: ScreenSizeLogic.blockSizeVertical * 2,
            numberSpacing: ScreenSizeLogic.blockSizeVertical * .5,
          ),
          NumberLogic.getNumbers(
            numbers: HighScoreLogic.getScore(place - 1),
            numberColor: NumberColor.tan,
            numberHeight: ScreenSizeLogic.blockSizeVertical * 2,
            numberSpacing: ScreenSizeLogic.blockSizeVertical * .5,
          ),
        ],
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
