enum ScorecardStatus { complete, incomplete, pass }

enum DiceStatus { initial, unselected, selected, zombie }

enum UndoStatus { unused, used }

class CurrentState {
  static late int rollCount;

  static late List<UndoStatus> undoUsed;

  static late List<int> diceValues;
  static late List<DiceStatus> diceStatus;

  static late List<int> scorecardValues;
  static late List<ScorecardStatus> scorecardStatus;

  static late int upperTotal;
  static late int lowerTotal;
  static late int grandTotal;

  static late int zombieCount;

  static init() {
    rollCount = 0;

    undoUsed = List.filled(3, UndoStatus.unused);

    diceValues = List.filled(5, 0);
    diceStatus = List.filled(5, DiceStatus.initial);

    scorecardValues = List.filled(14, 0);
    scorecardStatus = List.filled(14, ScorecardStatus.incomplete);

    upperTotal = 0;
    lowerTotal = 0;
    grandTotal = 0;

    zombieCount = 0;
  }
}

class PastState {
  static late List<Map> past;

  static init() {
    past = [];
  }
}
