import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF2596be);
const kSecondaryColor = Color(0xFF4098A7);
const kThirdColor = Color(0xFFFFDCBC);
const kLightBackground = Color(0xFF9fa2b2);
const kWhiteColor = Colors.white;
const kBlackColor = Colors.black;
const kBackground = Color(0xFF076D82);

class AppTheme {
  static const kBigTitle = TextStyle(
    color: kWhiteColor,
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );

  static const kHeadingOne = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const kSeeAllText = TextStyle(color: kPrimaryColor);

  static final kBodyText = TextStyle(
    color: Colors.grey.shade500,
    fontSize: 12,
  );

  static const kCardTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}
