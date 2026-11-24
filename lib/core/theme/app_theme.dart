import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static TextStyle display({double size = 32, FontWeight? weight}) {
    return GoogleFonts.fraunces(
      fontSize: size,
      fontWeight: weight ?? FontWeight.w600,
      color: AppColors.ink,
      height: 1.15,
      letterSpacing: -0.4,
    );
  }

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.ink,
        surface: AppColors.background,
        onSurface: AppColors.ink,
        error: AppColors.danger,
      ),
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      textTheme: GoogleFonts.dmSansTextTheme(
        base.textTheme,
      ).apply(bodyColor: AppColors.ink, displayColor: AppColors.ink),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        foregroundColor: AppColors.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.ink,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: StadiumBorder(),
        extendedTextStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.paper,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        dragHandleColor: AppColors.line,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.ink,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.ink,
        selectionColor: AppColors.ink.withValues(alpha: 0.14),
        selectionHandleColor: AppColors.ink,
      ),
    );
  }
}
