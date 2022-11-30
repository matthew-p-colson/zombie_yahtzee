import 'package:zombie_yahtzee/models/game_state.dart';

class ZombieLogic {
  static List<String> zombieCountImages = [];

  static init() {
    for (int i = 0; i < 11; i++) {
      zombieCountImages.add('images/zombie_count/$i.png');
    }
  }

  static getZombieCountImage() {
    return zombieCountImages[CurrentState.zombieCount];
  }

  static addZombie() {
    CurrentState.zombieCount++;
  }
}
