import 'package:flutter/material.dart';

abstract final class AppColors {
  static const background = Color(0xFFF3EFE7);
  static const paper = Color(0xFFFFFDF8);
  static const ink = Color(0xFF26231F);
  static const inkSoft = Color(0xFF5B564E);
  static const muted = Color(0xFF9A948A);
  static const line = Color(0xFFE4DED3);
  static const danger = Color(0xFFB8463C);
}

abstract final class NotePalette {
  static const colors = [
    Color(0xFFFFFDF8),
    Color(0xFFFBEAB8),
    Color(0xFFF8D5C2),
    Color(0xFFF2CFD7),
    Color(0xFFDCD5F2),
    Color(0xFFCFE1F1),
    Color(0xFFCDE8D7),
    Color(0xFFE0E5CC),
  ];

  static Color of(int index) {
    if (index < 0 || index >= colors.length) return colors.first;
    return colors[index];
  }
}
