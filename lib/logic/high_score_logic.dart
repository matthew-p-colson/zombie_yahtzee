import 'package:shared_preferences/shared_preferences.dart';
import 'package:zombie_yahtzee/models/game_state.dart';

class HighScoreLogic {
  static late SharedPreferences prefs;

  static Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static setScore(int scoreNumber, int score) {
    prefs.setInt('high score $scoreNumber', score);
  }

  static getScore(int scoreNumber) {
    return prefs.getInt('high score $scoreNumber') ?? 0;
  }

  static getScores() {
    List<int> scores = [];

    for (int i = 0; i < 10; i++) {
      scores.add(prefs.getInt('high score $i') ?? 0);
    }

    return scores;
  }

  static setScores(List<int> scores) {
    for (int i = 0; i < 10; i++) {
      prefs.setInt('high score $i', scores[i]);
    }
  }

  static addHighScore() {
    List<int> scores = getScores();
    scores.add(CurrentState.grandTotal);
    scores.sort();
    scores = scores.reversed.toList();
    scores.removeLast();
    setScores(scores);
  }

  static isHighScore(int score) {
    for (int highScore in getScores()) {
      if (score > highScore) {
        return true;
      }
    }
    return false;
  }

  static getPlace(int score) {
    List<int> scores = getScores();

    for (int i = 0; i < scores.length; i++) {
      if (score > scores[i]) {
        return i;
      }
    }
    return 0;
  }
}
