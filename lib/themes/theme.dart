import 'package:flutter/material.dart';

const Color kBlue = Color(0xFF0146E9);
const Color kWhite = Color(0xFFFFFFFF);
const Color kIce = Color(0xFFF6F7FB);

const Color kPrimary = kBlue;

const Color kText = Color(0xFF282D40);
const Color kSecondaryText = Color(0xFF58637F);

ThemeData getLightTheme = ThemeData.light().copyWith(
  appBarTheme: AppBarTheme(
    backgroundColor: kWhite,
    foregroundColor: kText,
    elevation: 1,
    shadowColor: Colors.grey.withOpacity(.2),
  ),
  scaffoldBackgroundColor: kIce,
  primaryColor: kPrimary,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: kPrimary,
    unselectedIconTheme: IconThemeData(
      color: kSecondaryText.withOpacity(.4),
    ),
  ),
);
