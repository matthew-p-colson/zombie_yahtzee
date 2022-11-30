import 'dart:math';

import 'package:zombie_yahtzee/logic/state_logic.dart';
import 'package:zombie_yahtzee/logic/zombie_logic.dart';
import 'package:zombie_yahtzee/models/game_state.dart';

class DiceLogic {
  static Map diceImages = {};
  static late String rollButton;
  static List<String> rollCountImages = [];

  static init() {
    for (int i = 0; i < 8; i++) {
      diceImages[i] = {
        DiceStatus.initial: 'images/logos/logo_border.png',
        DiceStatus.unselected: 'images/dice/unselected/$i.png',
        DiceStatus.selected: 'images/dice/selected/$i.png',
        DiceStatus.zombie: 'images/dice/selected/$i.png',
      };
    }

    rollButton = 'images/roll.png';

    for (int i = 0; i < 4; i++) {
      rollCountImages.add('images/roll_count/$i.png');
    }
  }

  static getDieImage(int dieNumber) {
    return diceImages[CurrentState.diceValues[dieNumber]]
        [CurrentState.diceStatus[dieNumber]];
  }

  static getDiceImages() {
    List<String> currentDiceImages = [];

    for (int i = 0; i < CurrentState.diceValues.length; i++) {
      currentDiceImages.add(
        getDieImage(i),
      );
    }
    return currentDiceImages;
  }

  static getRollCountImage() {
    return rollCountImages[CurrentState.rollCount];
  }

  static toggleStatus(int dieNumber) {
    if (CurrentState.diceStatus[dieNumber] != DiceStatus.zombie) {
      if (CurrentState.rollCount > 0) {
        if (CurrentState.diceStatus[dieNumber] == DiceStatus.selected) {
          CurrentState.diceStatus[dieNumber] = DiceStatus.unselected;
        } else if (CurrentState.diceStatus[dieNumber] ==
            DiceStatus.unselected) {
          CurrentState.diceStatus[dieNumber] = DiceStatus.selected;
        }
      }
    }
  }

  static rollDice() {
    if (CurrentState.rollCount < 3) {
      StateLogic.currentToPast();
      int count = 0;
      for (int i = 0; i < CurrentState.diceValues.length; i++) {
        if (CurrentState.diceStatus[i] == DiceStatus.initial ||
            CurrentState.diceStatus[i] == DiceStatus.unselected) {
          int weighted = Random().nextInt(100);
          if (weighted < 20) {
            CurrentState.diceValues[i] = Random().nextInt(8);
          } else {
            CurrentState.diceValues[i] = Random().nextInt(6) + 1;
          }
          if (CurrentState.diceValues[i] == 0) {
            CurrentState.diceStatus[i] = DiceStatus.zombie;
            ZombieLogic.addZombie();
          } else if (CurrentState.diceStatus[i] == DiceStatus.initial) {
            CurrentState.diceStatus[i] = DiceStatus.unselected;
          }
          count++;
        }
      }
      if (count > 0) {
        CurrentState.rollCount++;
        return true;
      } else {
        StateLogic.pastToCurrent();
      }
    }
    return false;
  }

  static resetDice() {
    CurrentState.diceValues = List.filled(5, 0);
    CurrentState.diceStatus = List.filled(5, DiceStatus.initial);
    CurrentState.rollCount = 0;
  }
}
