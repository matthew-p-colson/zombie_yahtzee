import 'package:zombie_yahtzee/logic/number_logic.dart';
import 'package:zombie_yahtzee/logic/scoring_logic.dart';
import 'package:zombie_yahtzee/logic/state_logic.dart';
import 'package:zombie_yahtzee/logic/zombie_logic.dart';
import 'package:zombie_yahtzee/models/game_state.dart';

class ScorecardLogic {
  static Map scorecardImages = {};

  static init() {
    for (int i = 0; i < 14; i++) {
      scorecardImages[i] = {
        ScorecardStatus.incomplete: 'images/cards/unselected/$i.png',
        ScorecardStatus.complete: 'images/cards/selected/$i.png',
        ScorecardStatus.pass: 'images/cards/pass.png',
      };
    }
  }

  static updateGrandTotal() {
    CurrentState.grandTotal = CurrentState.upperTotal + CurrentState.lowerTotal;
  }

  static getGrandTotal() {
    return CurrentState.grandTotal;
  }

  static updateBonus() {
    if (CurrentState.scorecardStatus[6] == ScorecardStatus.incomplete) {
      int total = 0;
      int unComplete = 0;
      for (int i = 0; i < 6; i++) {
        total += CurrentState.scorecardValues[i];
        if (CurrentState.scorecardStatus[i] == ScorecardStatus.incomplete) {
          unComplete++;
        }
      }
      if (total >= 63) {
        CurrentState.scorecardStatus[6] = ScorecardStatus.complete;
        CurrentState.scorecardValues[6] = 35;
      } else if (unComplete == 0) {
        CurrentState.scorecardStatus[6] = ScorecardStatus.pass;
        CurrentState.scorecardValues[6] = 0;
        ZombieLogic.addZombie();
      }
    }
  }

  static updateUpperTotal() {
    int total = 0;

    for (int i = 0; i < 7; i++) {
      total += CurrentState.scorecardValues[i];
    }

    CurrentState.upperTotal = total;
  }

  static getUpperTotal() {
    return CurrentState.upperTotal;
  }

  static updateLowerTotal() {
    int total = 0;

    for (int i = 7; i < 14; i++) {
      total += CurrentState.scorecardValues[i];
    }

    CurrentState.lowerTotal = total;
  }

  static getLowerTotal() {
    return CurrentState.lowerTotal;
  }

  static updateTotals() {
    updateUpperTotal();
    updateLowerTotal();
    updateGrandTotal();
  }

  static getScorecardImage(int scorecardNumber) {
    return scorecardImages[scorecardNumber]
        [CurrentState.scorecardStatus[scorecardNumber]];
  }

  static getScorecardImages() {
    List<String> currentScorecardImages = [];
    for (int i = 0; i < CurrentState.scorecardStatus.length; i++) {
      currentScorecardImages.add(getScorecardImage(i));
    }
    return currentScorecardImages;
  }

  static getScorecardValues() {
    List<int> currentScorecardValues = [];
    for (int i = 0; i < CurrentState.scorecardValues.length; i++) {
      currentScorecardValues.add(CurrentState.scorecardValues[i]);
    }
    return currentScorecardValues;
  }

  static getScorecardValue(int scorecardNumber) {
    return CurrentState.scorecardValues[scorecardNumber];
  }

  static getScorecardValueColor(int cardNumber) {
    if (CurrentState.scorecardStatus[cardNumber] ==
        ScorecardStatus.incomplete) {
      return NumberColor.tan;
    } else if (CurrentState.scorecardStatus[cardNumber] ==
        ScorecardStatus.complete) {
      return NumberColor.green;
    } else {
      return NumberColor.red;
    }
  }

  static getScorecardValueColors() {
    List<NumberColor> currentScorecardValueColors = [];

    for (int i = 0; i < CurrentState.scorecardStatus.length; i++) {
      currentScorecardValueColors.add(getScorecardValueColor(i));
    }

    return currentScorecardValueColors;
  }

  static getScore(int cardNumber) {
    if (cardNumber != 6) {
      if (CurrentState.scorecardStatus[cardNumber] ==
          ScorecardStatus.incomplete) {
        if (CurrentState.rollCount > 0) {
          StateLogic.currentToPast();
          int score = Scoring.getScore(cardNumber, CurrentState.diceValues);
          if (score == 0) {
            CurrentState.scorecardStatus[cardNumber] = ScorecardStatus.pass;
            ZombieLogic.addZombie();
          } else {
            CurrentState.scorecardStatus[cardNumber] = ScorecardStatus.complete;
            CurrentState.scorecardValues[cardNumber] = score;
          }
        }
      } else if (cardNumber == 12) {
        if (CurrentState.scorecardStatus[cardNumber] ==
            ScorecardStatus.complete) {
          CurrentState.scorecardValues[cardNumber] =
              Scoring.yahtzee(CurrentState.diceValues);
        }
      }
    }
  }

  static isGameOver() {
    int count = 0;

    for (int i = 0; i < 6; i++) {
      if (CurrentState.scorecardStatus[i] == ScorecardStatus.incomplete) {
        count++;
      }
    }

    for (int i = 7; i < 14; i++) {
      if (CurrentState.scorecardStatus[i] == ScorecardStatus.incomplete) {
        count++;
      }
    }

    return count == 0 ? true : false;
  }
}
