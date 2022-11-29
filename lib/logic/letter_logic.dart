import 'package:flutter/material.dart';

enum LetterColor { green, red, tan }

class LetterLogic {
  static Map letterImages = {};

  static init() {
    for (int i = 65; i <= 90; i++) {
      letterImages[String.fromCharCode(i)] = {
        LetterColor.green: 'images/letters/green/${String.fromCharCode(i)}.png',
        LetterColor.red: 'images/letters/red/${String.fromCharCode(i)}.png',
        LetterColor.tan: 'images/letters/tan/${String.fromCharCode(i)}.png',
      };
    }
  }

  static getLetters({
    required String letters,
    required LetterColor letterColor,
    required double letterHeight,
    required double letterSpacing,
    required double wordSpacing,
    required MainAxisAlignment alignment,
  }) {
    List<String> splitLetters = letters.toUpperCase().split('');
    List<Widget> imageList = [];

    for (int i = 0; i < splitLetters.length; i++) {
      if (splitLetters[i] == String.fromCharCode(32)) {
        imageList.add(
          SizedBox(
            width: wordSpacing,
          ),
        );
      } else {
        imageList.add(
          Image.asset(
            letterImages[splitLetters[i]][letterColor],
            height: letterHeight,
          ),
        );
        if (i < splitLetters.length - 1) {
          imageList.add(
            SizedBox(
              width: letterSpacing,
            ),
          );
        }
      }
    }
    return Row(
      mainAxisAlignment: alignment,
      children: imageList,
    );
  }
}
