import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reze_melhor/application/states/theme_mode_controller.dart';
abstract class ColorTheme {
  ColorTheme({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.background,
  });

  Color primary;
  Color secondary;
  Color tertiary;
  Color background;
}

class AdaptativeColor {

  final ThemeModeController themeModeController =
      Get.find<ThemeModeController>();


  Color getAdaptiveColor(BuildContext context) {
    final themeMode = themeModeController.themeMode.value;

    if (themeMode == ThemeMode.light) return Colors.black;
    if (themeMode == ThemeMode.dark) return Colors.white;
    return MediaQuery.of(context).platformBrightness == Brightness.light
        ? Colors.black
        : Colors.white;
  }

  Color getAdaptiveColorInvert(BuildContext context) {
    final themeMode = themeModeController.themeMode.value;

    if (themeMode == ThemeMode.light) {
      return Colors.white;
    }
    if (themeMode == ThemeMode.dark) {
      return Colors.black;
    }
    if (themeMode == ThemeMode.system) {
      if (MediaQuery.of(context).platformBrightness == Brightness.light) {
        return Colors.white;
      }
      if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
        return Colors.black;
      }
    }
    return Colors.transparent;
  }

  Color getAdaptiveColorSuave(BuildContext context) {
    final themeMode = themeModeController.themeMode.value;

    if (themeMode == ThemeMode.light) {
      return const Color.fromARGB(255, 228, 228, 228);
    }
    if (themeMode == ThemeMode.dark) {
      return Color.fromARGB(255, 19, 19, 19);
    }
    if (themeMode == ThemeMode.system) {
      if (MediaQuery.of(context).platformBrightness == Brightness.light) {
        return const Color.fromARGB(255, 228, 228, 228);
      }
      if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
        return Color.fromARGB(255, 19, 19, 19);
      }
    }
    return Colors.transparent;
  }
}

class RedColorScheme extends ColorTheme {
  RedColorScheme()
    : super(
        primary: const Color(0xFFBB0000),
        secondary: const Color(0xFFB30000),
        tertiary: const Color(0xFF6F0000),
        background: const Color(0xFFE0E0E0),
      );
}

class PurpleColorScheme extends ColorTheme {
  PurpleColorScheme()
    : super(
        primary: const Color(0xFF6A1B9A),
        secondary: const Color(0xFF320B86),
        tertiary: const Color(0xFF38006B),
        background: const Color(0xFFE0E0E0),
      );
}

class GreenColorScheme extends ColorTheme {
  GreenColorScheme()
    : super(
        primary: const Color(0xFF00C853),
        secondary: const Color(0xFF00B248),
        tertiary: const Color(0xFF007E33),
        background: const Color(0xFFE0E0E0),
      );
}

class BlueColorScheme extends ColorTheme {
  BlueColorScheme()
    : super(
        primary: const Color(0xFF1BA7F8),
        secondary: const Color(0xFF1744FF),
        tertiary: const Color(0xFF0033CC),
        background: const Color(0xFFE0E0E0),
      );
}

class YellowColorScheme extends ColorTheme {
  YellowColorScheme()
    : super(
        primary: const Color(0xFFFFD600),
        secondary: const Color(0xFFE6C200),
        tertiary: const Color(0xFFB3A600),
        background: const Color(0xFFE0E0E0),
      );
}

class PinkColorScheme extends ColorTheme {
  PinkColorScheme()
    : super(
        primary: const Color(0xFFE91E63),
        secondary: const Color(0xFFD81B60),
        tertiary: const Color(0xFFA00037),
        background: const Color(0xFFE0E0E0),
      );
}
