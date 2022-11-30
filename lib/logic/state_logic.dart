import 'package:zombie_yahtzee/models/game_state.dart';

class StateLogic {
  static currentToPast() {
    Map current = {
      'rollCount': CurrentState.rollCount,
      'diceValues': List.from(CurrentState.diceValues),
      'diceStatus': List.from(CurrentState.diceStatus),
      'scorecardValues': List.from(CurrentState.scorecardValues),
      'scorecardStatus': List.from(CurrentState.scorecardStatus),
      'upperTotal': CurrentState.upperTotal,
      'lowerTotal': CurrentState.lowerTotal,
      'grandTotal': CurrentState.grandTotal,
      'zombieCount': CurrentState.zombieCount,
    };

    PastState.past.add(Map.from(current));
  }

  static pastToCurrent() {
    Map past = PastState.past.removeLast();
    CurrentState.rollCount = past['rollCount'];
    CurrentState.diceValues = List.from(past['diceValues']);
    CurrentState.diceStatus = List.from(past['diceStatus']);
    CurrentState.scorecardValues = List.from(past['scorecardValues']);
    CurrentState.scorecardStatus = List.from(past['scorecardStatus']);
    CurrentState.upperTotal = past['upperTotal'];
    CurrentState.lowerTotal = past['lowerTotal'];
    CurrentState.grandTotal = past['grandTotal'];
    CurrentState.zombieCount = past['zombieCount'];
  }

  static restartGame() {
    CurrentState.init();
    PastState.init();
  }
}
