import 'package:flutter/material.dart';

enum NumberColor { green, red, tan }

class NumberLogic {
  static Map numberImages = {};

  static init() {
    for (int i = 0; i < 10; i++) {
      numberImages[i] = {
        NumberColor.green: 'images/numbers/green/$i.png',
        NumberColor.red: 'images/numbers/red/$i.png',
        NumberColor.tan: 'images/numbers/tan/$i.png',
      };
    }
  }

  static getNumber({
    required int number,
    required NumberColor numberColor,
    required double imageHeight,
  }) {
    return Image.asset(
      numberImages[number][numberColor],
      height: imageHeight,
    );
  }

  static getNumbers({
    required int numbers,
    required NumberColor numberColor,
    required double numberHeight,
    required double numberSpacing,
  }) {
    List<Widget> imageList = [];

    int hundreds = numbers ~/ 100;
    int remainder = numbers % 100;
    int tens = remainder ~/ 10;
    int ones = numbers % 10;

    imageList.add(
      Image.asset(
        numberImages[hundreds][numberColor],
        height: numberHeight,
      ),
    );
    imageList.add(
      SizedBox(
        width: numberSpacing,
      ),
    );
    imageList.add(
      Image.asset(
        numberImages[tens][numberColor],
        height: numberHeight,
      ),
    );
    imageList.add(
      SizedBox(
        width: numberSpacing,
      ),
    );
    imageList.add(
      Image.asset(
        numberImages[ones][numberColor],
        height: numberHeight,
      ),
    );

    return Row(
      children: imageList,
    );
  }
}
