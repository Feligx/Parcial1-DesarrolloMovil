import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/difficulty.dart';

class GameController extends GetxController {
  var difficulty = 0.obs;
  var mode = 0.obs;
  var originalNumber = ''.obs;
  var testNumber = ''.obs;
  var score = 0.obs;
  var currPLayer = 'A'.obs;
  var scores = {
    'A': 0,
    'B': 0,
  }.obs;

  void setDifficulty(int newDifficulty) {
    print(difficulty);
    difficulty.value = newDifficulty;
    print(difficulty);
  }

  void setPlayerMode(int newMode) {
    print(mode);
    mode.value = newMode;
    print(mode);
  }

  void setOriginalNumber(String newNumber) {
    print(originalNumber);
    originalNumber.value = newNumber;
    print(originalNumber);
  }

  void setTestNumber(String newNumber) {
    print(testNumber);
    testNumber.value = newNumber;
    print(testNumber);
  }

  void increaseScore() {
    print(score);
    score.value++;
    print(score);
  }

  void resetGame() {
    difficulty.value = 0;
    mode.value = 0;
    originalNumber.value = '';
    testNumber.value = '';
    score.value = 0;
    currPLayer.value = 'A';
  }

  void resetNumbers() {
    originalNumber.value = '';
    testNumber.value = '';
  }

  void resetScore() {
    score.value = 0;
  }

  void changePlayer() {
    if (currPLayer.value == 'A') {
      currPLayer.value = 'B';
    } else {
      currPLayer.value = 'A';
    }
  }

  void setPlayerScore() {
    scores[currPLayer.value] = score.value;
  }

  void hintIncreaseScore({int valueToAdd = 5}) {
    score.value += valueToAdd;
  }

  void checkWinner() {
    if (scores['A'] != scores['B'] && scores['A']! > 0 && scores['B']! > 0) {
      Get.defaultDialog(
          title: 'Ganador',
          middleText: 'El ganador es el jugador ${scores['A']! < scores['B']! ? 'A' : 'B'}',
          textConfirm: 'Aceptar',
          onConfirm: () {
            resetGame();
            Get.offAll(() => PickDifficultyView());
          }
      );
    } else if (scores['A'] == scores['B'] && scores['A']! > 0 && scores['B']! > 0) {
      Get.defaultDialog(
          title: 'Empate',
          middleText: 'Los jugadores empataron',
          textConfirm: 'Aceptar',
          onConfirm: () {
            resetGame();
            Get.offAll(() => PickDifficultyView());
          }
      );
    }
  }

  String getGameScreenTitle() {
    if (mode.value == 0) {
      return 'Intentos: ${mode.value == 0 ? score.value : scores[currPLayer.value]}';
    } else {
      return 'Jugador: ${currPLayer.value} Intentos: ${mode.value == 0 ? score
          .value : scores[currPLayer.value]}';
    }
  }
}
