import 'package:zombie_yahtzee/logic/state_logic.dart';
import 'package:zombie_yahtzee/models/game_state.dart';

class UndoLogic {
  static Map undoImages = {};

  static init() {
    undoImages[UndoStatus.unused] = 'images/undo/undo.png';
    undoImages[UndoStatus.used] = 'images/undo/used.png';
  }

  static getUndoImage(int undoNumber) {
    return undoImages[CurrentState.undoUsed[undoNumber]];
  }

  static useUndo(int undoNumber) {
    if (CurrentState.undoUsed[undoNumber] == UndoStatus.unused) {
      if (PastState.past.isNotEmpty) {
        StateLogic.pastToCurrent();
        CurrentState.undoUsed[undoNumber] = UndoStatus.used;
      }
    }
  }
}
