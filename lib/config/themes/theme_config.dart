import 'package:flutter/material.dart';

class CustomTheme {
  final ThemeData themeSettings;

  final String name;

  const CustomTheme({required this.themeSettings, required this.name});
}

final ThemeData pokeBallTheme = ThemeData(
  useMaterial3: true,
  colorScheme:
      ColorScheme.fromSeed(seedColor: const Color.fromRGBO(209, 66, 66, 1.0)),
  hintColor: const Color(0xffffffff),
);

final ThemeData blueTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromRGBO(33, 101, 220, 1.0)),
    hintColor: const Color(0xFFFFFFFF));

final ThemeData purpleTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromRGBO(122, 46, 198, 1.0)),
    hintColor: const Color(0xFFFFFFFF));

final ThemeData goldenTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromRGBO(222, 173, 30, 1.0)),
    hintColor: const Color(0xFFFFFFFF));

List<CustomTheme> listOfThemes = [
  CustomTheme(themeSettings: pokeBallTheme, name: 'pokeball_theme'),
  CustomTheme(themeSettings: blueTheme, name: 'Blue_Theme'),
  CustomTheme(themeSettings: purpleTheme, name: 'purple_Theme'),
  CustomTheme(themeSettings: goldenTheme, name: 'golden_theme')
];
