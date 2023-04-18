import 'dart:math';

String randNumber(int n) {
  String randNum = '';
  var rng = new Random();
  for (int i = 0; i < n; i++) {
    int nextNum = rng.nextInt(10);
    while (randNum.contains('$nextNum')){
      nextNum = rng.nextInt(10);
    }
    randNum += '$nextNum';
  }
  return randNum;
}

String randHexNumber(int n) {
  String randNum = '';
  var rng = new Random();
  for (int i = 0; i < n; i++) {
    int nextNum = rng.nextInt(16);
    while (randNum.contains(nextNum.toRadixString(16))){
      nextNum = rng.nextInt(16);
    }
    randNum += nextNum.toRadixString(16);
  }
  return randNum;

}

List<dynamic> getScore(String original, String test) {
  int points = 0;
  List<int> famasIndexes = [];
  List<String> originalNumPositions = original.split('');
  List<String> testNumPositions = test.toLowerCase().split('');

  for (int i = 0; i < originalNumPositions.length; i++) {
    if (originalNumPositions[i] == testNumPositions[i]) {
      famasIndexes.add(i);
    } else if (originalNumPositions.contains(testNumPositions[i])){
      points += 1;
    }
  }
  return [famasIndexes, points];
}

bool hasRepeatedDigits(String numberString) {
  Set<String> seenDigits = {};
  for (int i = 0; i < numberString.length; i++) {
    String digit = numberString[i];
    if (seenDigits.contains(digit)) {
      return true; // Found a repeated digit
    }
    seenDigits.add(digit);
  }
  return false; // No repeated digits found
}