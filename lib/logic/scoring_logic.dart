import 'package:zombie_yahtzee/models/game_state.dart';

class Scoring {
  static _upper(int value, List<num> dice) {
    int count = 0;

    for (int i = 0; i < dice.length; i++) {
      if (dice[i] == value || dice[i] == 7) {
        count++;
      }
    }
    return count * value;
  }

  static aces(List<num> dice) {
    return _upper(1, dice);
  }

  static twos(List<num> dice) {
    return _upper(2, dice);
  }

  static threes(List<num> dice) {
    return _upper(3, dice);
  }

  static fours(List<num> dice) {
    return _upper(4, dice);
  }

  static fives(List<num> dice) {
    return _upper(5, dice);
  }

  static sixes(List<num> dice) {
    return _upper(6, dice);
  }

  static threeOfKind(List<num> dice) {
    Map counts = {};
    num score = 0;
    int wildCount = 0;
    int wildValue = 0;

    for (num die in dice) {
      counts[die] = counts.containsKey(die) ? counts[die] + 1 : 1;
    }

    counts.removeWhere((key, value) => key == 0);

    if (counts.containsKey(7)) {
      wildCount = counts[7];
      counts.removeWhere((key, value) => key == 7);
    }

    if (wildCount >= 3) {
      score = 30;
    } else {
      for (int i = 6; i > 0; i--) {
        if (counts.containsKey(i) && counts[i] + wildCount >= 3) {
          wildValue = i * wildCount;

          for (int j = 0; j < 7; j++) {
            if (counts.containsKey(j)) {
              score += counts[j] * j;
            }
          }

          score += wildValue;
          break;
        }
      }
    }
    return score;
  }

  static fourOfKind(List<num> dice) {
    Map counts = {};
    num score = 0;
    int wildCount = 0;
    int wildValue = 0;

    for (num die in dice) {
      counts[die] = counts.containsKey(die) ? counts[die] + 1 : 1;
    }

    counts.removeWhere((key, value) => key == 0);

    if (counts.containsKey(7)) {
      wildCount = counts[7];
      counts.removeWhere((key, value) => key == 7);
    }

    if (wildCount >= 4) {
      score = 30;
    } else {
      for (int i = 6; i > 0; i--) {
        if (counts.containsKey(i) && counts[i] + wildCount >= 4) {
          wildValue = i * wildCount;

          for (int j = 0; j < 7; j++) {
            if (counts.containsKey(j)) {
              score += counts[j] * j;
            }
          }

          score += wildValue;
          break;
        }
      }
    }
    return score;
  }

  static fullHouse(List<num> dice) {
    Map counts = {};
    for (var die in dice) {
      counts[die] = counts.containsKey(die) ? counts[die] + 1 : 1;
    }
    counts.removeWhere((key, value) => key == 0);
    if (counts.length == 5) return 0;
    if (counts.containsValue(3) && counts.containsValue(2)) return 25;
    if (counts.containsKey(7)) {
      int wildCount = counts[7];
      if (wildCount >= 3) return 25;
      if (counts.containsValue(3)) return 25;
      int twos = 0;
      counts.forEach((key, value) {
        if (value == 2) twos++;
      });
      if (twos == 2) return 25;
      if (twos == 1 && wildCount == 2) return 25;
    }
    return 0;
  }

  static smallStraight(List<num> dice) {
    dice = List.from(dice, growable: true);
    dice.removeWhere((die) => die == 0);
    if (dice.length < 4) return 0;
    int wild = 0;
    for (int i = 0; i < dice.length; i++) {
      if (dice[i] == 7) wild++;
    }
    dice.removeWhere((die) => die == 7);
    dice.sort();

    int count = 0;
    if (dice.contains(1)) count++;
    if (dice.contains(2)) count++;
    if (dice.contains(3)) count++;
    if (dice.contains(4)) count++;
    if (count + wild >= 4) return 30;

    count = 0;
    if (dice.contains(2)) count++;
    if (dice.contains(3)) count++;
    if (dice.contains(4)) count++;
    if (dice.contains(5)) count++;

    if (count + wild >= 4) return 30;

    count = 0;
    if (dice.contains(3)) count++;
    if (dice.contains(4)) count++;
    if (dice.contains(5)) count++;
    if (dice.contains(6)) count++;

    if (count + wild >= 4) return 30;

    return 0;
  }

  static largeStraight(List<num> dice) {
    dice = List.from(dice, growable: true);
    dice.removeWhere((die) => die == 0);
    if (dice.length < 5) return 0;
    int wild = 0;
    for (int i = 0; i < dice.length; i++) {
      if (dice[i] == 7) wild++;
    }
    dice.removeWhere((die) => die == 7);
    dice.sort();

    int count = 0;
    if (dice.contains(1)) count++;
    if (dice.contains(2)) count++;
    if (dice.contains(3)) count++;
    if (dice.contains(4)) count++;
    if (dice.contains(5)) count++;
    if (count + wild >= 5) return 40;

    count = 0;
    if (dice.contains(2)) count++;
    if (dice.contains(3)) count++;
    if (dice.contains(4)) count++;
    if (dice.contains(5)) count++;
    if (dice.contains(6)) count++;

    if (count + wild >= 5) return 40;

    return 0;
  }

  static yahtzee(List<num> dice) {
    Map counts = {};
    num score = 0;
    int wildCount = 0;

    for (num die in dice) {
      counts[die] = counts.containsKey(die) ? counts[die] + 1 : 1;
    }

    counts.removeWhere((key, value) => key == 0);

    if (counts.containsKey(7)) {
      wildCount = counts[7];
      counts.removeWhere((key, value) => key == 7);
    }

    if (wildCount >= 5) {
      if (CurrentState.scorecardStatus[12] == ScorecardStatus.complete) {
        score = CurrentState.scorecardValues[12] + 100;
      } else if (CurrentState.scorecardStatus[12] ==
          ScorecardStatus.incomplete) {
        score = 50;
      }
    } else {
      for (int i = 6; i > 0; i--) {
        if (counts.containsKey(i) && counts[i] + wildCount >= 5) {
          if (CurrentState.scorecardStatus[12] == ScorecardStatus.complete) {
            score = CurrentState.scorecardValues[12] + 100;
          } else if (CurrentState.scorecardStatus[12] ==
              ScorecardStatus.incomplete) {
            score = 50;
          }
          break;
        }
      }
    }
    return score;
  }

  static chance(List<num> dice) {
    num score = 0;
    dice = List.from(dice, growable: true);
    dice.removeWhere((value) => value == 0);

    for (num die in dice) {
      if (die == 7) {
        score += 6;
      } else {
        score += die;
      }
    }
    return score;
  }

  static getScore(int index, List<num> dice) {
    switch (index) {
      case 0:
        return aces(dice);
      case 1:
        return twos(dice);
      case 2:
        return threes(dice);
      case 3:
        return fours(dice);
      case 4:
        return fives(dice);
      case 5:
        return sixes(dice);
      case 7:
        return threeOfKind(dice);
      case 8:
        return fourOfKind(dice);
      case 9:
        return fullHouse(dice);
      case 10:
        return smallStraight(dice);
      case 11:
        return largeStraight(dice);
      case 12:
        return yahtzee(dice);
      case 13:
        return chance(dice);
      default:
        return 0;
    }
  }
}
