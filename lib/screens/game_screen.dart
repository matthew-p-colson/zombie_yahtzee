import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zombie_yahtzee/logic/dice_logic.dart';
import 'package:zombie_yahtzee/logic/letter_logic.dart';
import 'package:zombie_yahtzee/logic/number_logic.dart';
import 'package:zombie_yahtzee/logic/scorecard_logic.dart';
import 'package:zombie_yahtzee/logic/screen_size_logic.dart';
import 'package:zombie_yahtzee/logic/undo_logic.dart';
import 'package:zombie_yahtzee/logic/zombie_logic.dart';
import 'package:zombie_yahtzee/screens/style.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> diceImages = List.from(DiceLogic.getDiceImages());
  String rollCountImage = DiceLogic.getRollCountImage();
  int grandTotal = ScorecardLogic.getGrandTotal();
  int upperTotal = ScorecardLogic.getUpperTotal();
  int lowerTotal = ScorecardLogic.getLowerTotal();
  List<String> scorecardImages = List.from(ScorecardLogic.getScorecardImages());
  List<int> scorecardValues = List.from(ScorecardLogic.getScorecardValues());
  List<NumberColor> scorecardValueColors =
      List.from(ScorecardLogic.getScorecardValueColors());
  String zombieCountImage = ZombieLogic.getZombieCountImage();

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
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/", (r) => false);
                    break;
                  case 3:
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
                  buildActionPopupMenuItem(2, 'Main Menu'),
                  buildActionPopupMenuItem(3, 'Quit'),
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
        margin: EdgeInsets.all(ScreenSizeLogic.blockSizeVertical * .5),
        padding: EdgeInsets.all(ScreenSizeLogic.blockSizeVertical * .5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Undo Container
            Container(
              margin: EdgeInsets.all(
                ScreenSizeLogic.blockSizeVertical * .5,
              ),
              padding: EdgeInsets.only(
                left: ScreenSizeLogic.blockSizeVertical,
                right: ScreenSizeLogic.blockSizeVertical,
              ),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      LetterLogic.getLetters(
                        letters: 'Total',
                        letterColor: LetterColor.tan,
                        letterHeight: ScreenSizeLogic.blockSizeVertical * 2,
                        letterSpacing: ScreenSizeLogic.blockSizeVertical * .5,
                        wordSpacing: ScreenSizeLogic.blockSizeVertical,
                        alignment: MainAxisAlignment.start,
                      ),
                      SizedBox(
                        width: ScreenSizeLogic.blockSizeVertical,
                      ),
                      NumberLogic.getNumbers(
                        numbers: grandTotal,
                        numberColor: NumberColor.tan,
                        numberHeight: ScreenSizeLogic.blockSizeVertical * 2,
                        numberSpacing: ScreenSizeLogic.blockSizeVertical * .5,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      buildUndoTextButton(0),
                      buildUndoTextButton(1),
                      buildUndoTextButton(2),
                    ],
                  ),
                ],
              ),
            ),
            // Scorecard Container
            Container(
              margin: EdgeInsets.all(
                ScreenSizeLogic.blockSizeVertical * .5,
              ),
              padding: EdgeInsets.fromLTRB(
                ScreenSizeLogic.blockSizeVertical,
                ScreenSizeLogic.blockSizeVertical,
                ScreenSizeLogic.blockSizeVertical,
                ScreenSizeLogic.blockSizeVertical * 2,
              ),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLeftCardRow(0),
                      buildLeftCardRow(1),
                      buildLeftCardRow(2),
                      buildLeftCardRow(3),
                      buildLeftCardRow(4),
                      buildLeftCardRow(5),
                      buildLeftCardRow(6),
                      Row(
                        children: [
                          LetterLogic.getLetters(
                            letters: 'Total',
                            letterColor: LetterColor.tan,
                            letterHeight: ScreenSizeLogic.blockSizeVertical * 2,
                            letterSpacing:
                                ScreenSizeLogic.blockSizeVertical * .5,
                            wordSpacing: ScreenSizeLogic.blockSizeVertical,
                            alignment: MainAxisAlignment.start,
                          ),
                          SizedBox(
                            width: ScreenSizeLogic.blockSizeVertical * 2,
                          ),
                          NumberLogic.getNumbers(
                            numbers: upperTotal,
                            numberColor: NumberColor.tan,
                            numberHeight: ScreenSizeLogic.blockSizeVertical * 2,
                            numberSpacing: ScreenSizeLogic.blockSizeVertical,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        zombieCountImage,
                        width: ScreenSizeLogic.blockSizeVertical * 4.5,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      buildRightCardRow(7),
                      buildRightCardRow(8),
                      buildRightCardRow(9),
                      buildRightCardRow(10),
                      buildRightCardRow(11),
                      buildRightCardRow(12),
                      buildRightCardRow(13),
                      Row(
                        children: [
                          NumberLogic.getNumbers(
                            numbers: lowerTotal,
                            numberColor: NumberColor.tan,
                            numberHeight: ScreenSizeLogic.blockSizeVertical * 2,
                            numberSpacing: ScreenSizeLogic.blockSizeVertical,
                          ),
                          SizedBox(
                            width: ScreenSizeLogic.blockSizeVertical * 2,
                          ),
                          LetterLogic.getLetters(
                            letters: 'Total',
                            letterColor: LetterColor.tan,
                            letterHeight: ScreenSizeLogic.blockSizeVertical * 2,
                            letterSpacing:
                                ScreenSizeLogic.blockSizeVertical * .5,
                            wordSpacing: ScreenSizeLogic.blockSizeVertical,
                            alignment: MainAxisAlignment.start,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            // Dice Container
            Container(
              margin: EdgeInsets.all(
                ScreenSizeLogic.blockSizeVertical * .5,
              ),
              padding: EdgeInsets.all(
                ScreenSizeLogic.blockSizeVertical * .5,
              ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildDieTextButton(0),
                      buildDieTextButton(1),
                      buildDieTextButton(2),
                      buildDieTextButton(3),
                      buildDieTextButton(4),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            if (DiceLogic.rollDice()) {
                              if (ZombieLogic.tooManyZombies()) {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/zombie', (route) => false);
                              }
                              rollCountImage = DiceLogic.getRollCountImage();
                              diceImages = List.from(DiceLogic.getDiceImages());
                              zombieCountImage =
                                  ZombieLogic.getZombieCountImage();
                            }
                          });
                        },
                        child: Image.asset(
                          'images/roll.png',
                          height: 35.0,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            right: ScreenSizeLogic.blockSizeVertical),
                        child: Image.asset(
                          rollCountImage,
                          height: 35.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildLeftCardRow(int cardNumber) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              ScorecardLogic.getScore(cardNumber);
              ScorecardLogic.updateBonus();
              if (ZombieLogic.tooManyZombies()) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/zombie', (route) => false);
              }
              scorecardImages[cardNumber] =
                  ScorecardLogic.getScorecardImage(cardNumber);
              scorecardValues[cardNumber] =
                  ScorecardLogic.getScorecardValue(cardNumber);
              scorecardValueColors[cardNumber] =
                  ScorecardLogic.getScorecardValueColor(cardNumber);
              scorecardImages[6] = ScorecardLogic.getScorecardImage(6);
              scorecardValues[6] = ScorecardLogic.getScorecardValue(6);
              scorecardValueColors[6] =
                  ScorecardLogic.getScorecardValueColor(6);
              ScorecardLogic.updateTotals();
              zombieCountImage = ZombieLogic.getZombieCountImage();
              grandTotal = ScorecardLogic.getGrandTotal();
              upperTotal = ScorecardLogic.getUpperTotal();
              DiceLogic.resetDice();
              diceImages = List.from(DiceLogic.getDiceImages());
              rollCountImage = DiceLogic.getRollCountImage();
            });
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
          ),
          child: Image.asset(
            scorecardImages[cardNumber],
            height: ScreenSizeLogic.blockSizeVertical * 4,
          ),
        ),
        SizedBox(
          width: ScreenSizeLogic.blockSizeVertical,
        ),
        NumberLogic.getNumbers(
          numbers: scorecardValues[cardNumber],
          numberColor: scorecardValueColors[cardNumber],
          numberHeight: ScreenSizeLogic.blockSizeVertical * 3,
          numberSpacing: ScreenSizeLogic.blockSizeVertical,
        ),
      ],
    );
  }

  Row buildRightCardRow(int cardNumber) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        NumberLogic.getNumbers(
          numbers: scorecardValues[cardNumber],
          numberColor: scorecardValueColors[cardNumber],
          numberHeight: ScreenSizeLogic.blockSizeVertical * 3,
          numberSpacing: ScreenSizeLogic.blockSizeVertical,
        ),
        SizedBox(
          width: ScreenSizeLogic.blockSizeVertical,
        ),
        TextButton(
          onPressed: () {
            setState(() {
              ScorecardLogic.getScore(cardNumber);
              ScorecardLogic.updateBonus();
              if (ZombieLogic.tooManyZombies()) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/zombie', (route) => false);
              }
              scorecardImages[cardNumber] =
                  ScorecardLogic.getScorecardImage(cardNumber);
              scorecardValues[cardNumber] =
                  ScorecardLogic.getScorecardValue(cardNumber);
              scorecardValueColors[cardNumber] =
                  ScorecardLogic.getScorecardValueColor(cardNumber);
              ScorecardLogic.updateTotals();
              zombieCountImage = ZombieLogic.getZombieCountImage();
              grandTotal = ScorecardLogic.getGrandTotal();
              lowerTotal = ScorecardLogic.getLowerTotal();
              DiceLogic.resetDice();
              diceImages = List.from(DiceLogic.getDiceImages());
              rollCountImage = DiceLogic.getRollCountImage();
            });
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
          ),
          child: Image.asset(
            scorecardImages[cardNumber],
            height: ScreenSizeLogic.blockSizeVertical * 4,
          ),
        ),
      ],
    );
  }

  TextButton buildUndoTextButton(int undoNumber) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
      ),
      onPressed: () {
        setState(() {
          UndoLogic.useUndo(undoNumber);
          diceImages = List.from(DiceLogic.getDiceImages());
          rollCountImage = DiceLogic.getRollCountImage();
          scorecardImages = List.from(ScorecardLogic.getScorecardImages());
          scorecardValues = List.from(ScorecardLogic.getScorecardValues());
          scorecardValueColors =
              List.from(ScorecardLogic.getScorecardValueColors());
          zombieCountImage = ZombieLogic.getZombieCountImage();
          grandTotal = ScorecardLogic.getGrandTotal();
          upperTotal = ScorecardLogic.getUpperTotal();
          lowerTotal = ScorecardLogic.getLowerTotal();
        });
      },
      child: Image.asset(
        UndoLogic.getUndoImage(undoNumber),
        height: ScreenSizeLogic.blockSizeVertical * 3,
      ),
    );
  }

  TextButton buildDieTextButton(int diceNumber) {
    return TextButton(
      onPressed: () {
        setState(() {
          DiceLogic.toggleStatus(diceNumber);
          diceImages[diceNumber] = DiceLogic.getDieImage(diceNumber);
        });
      },
      child: Image.asset(
        diceImages[diceNumber],
        height: ScreenSizeLogic.blockSizeVertical * 5,
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
