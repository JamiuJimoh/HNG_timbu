import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: kBGColor,
      appBarTheme: const AppBarTheme().copyWith(
        elevation: 0.0,
        color: kBGColor,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: false,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 15.0,
        ),
      ),
    );
  }
}
