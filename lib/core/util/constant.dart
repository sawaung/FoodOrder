import 'dart:math';

const kBaseUrl = "www.themealdb.com";

  String generateRandomCode() {
    final random = Random();
    return (random.nextInt(900000) + 100000).toString();
  }