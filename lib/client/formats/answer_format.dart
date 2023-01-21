import 'package:flutter/material.dart';

class Answers {
  Widget answer(
  {
    required List jsonList, required String letter, required int counter, required int colorNumber
}) {
    return jsonList[counter]['answers']['answer_${letter}'] != null ? Container(
      height: 60,
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
          color: colorChange(colorNumber),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              ' ${letter.toUpperCase()}) ${jsonList[counter]['answers']['answer_${letter}']}',
              style: const TextStyle(color: Color.fromRGBO(1, 1, 1, 1)),
            )),
      ),
    ) : Container();
  }
}

Color colorChange(int colorNumber) {
  if (colorNumber == 0) {
    return Colors.white;
  } else if (colorNumber == 1) {
    return Colors.red;
  } else {
    return Colors.green;
  }
}
