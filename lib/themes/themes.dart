import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData themeData(
      {required bool isDarkTheme, required BuildContext context}) {
    return isDarkTheme
        ? ThemeData(
            fontFamily: 'RedditMono-Bold',
            scaffoldBackgroundColor:
                const Color(0xFF1E1E2C), // Màu nền xanh đậm
            primarySwatch: Colors.teal,
            primaryColorDark: const Color(0xFF141421), // Màu primary tối hơn
            dividerColor: const Color(0xFF383859), // Màu divider
            disabledColor: Colors.grey[700], // Màu disabled
            cardColor: const Color(0xFF25253A), // Màu card xanh đậm
            canvasColor: const Color(0xFF2A2A40), // Màu nền cho canvas
            brightness: Brightness.dark,
            appBarTheme: const AppBarTheme(
              color: Color(0xFF1E1E2C), // Màu nền cho AppBar
            ),
            buttonTheme: Theme.of(context)
                .buttonTheme
                .copyWith(colorScheme: const ColorScheme.dark()),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.white), // Text màu trắng
              bodyMedium:
                  TextStyle(color: Color(0xFFB0BEC5)), // Text màu xanh nhạt
              displayLarge:
                  TextStyle(color: Color(0xFF81C784)), // Màu xanh lá nhạt
              titleLarge:
                  TextStyle(color: Color(0xFF64FFDA)), // Màu xanh lục nhạt
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Color(0xFF7C4DFF), // Màu tím neon
            ),
            // toggleableActiveColor: const Color(0xFFFF4081), // Màu hồng neon
          )
        : ThemeData(
            fontFamily: 'RedditMono-Bold',
            scaffoldBackgroundColor:
                const Color(0xFFF0F5F9), // Màu nền xanh nhạt
            primarySwatch: Colors.purple,
            primaryColorDark: const Color(0xFFB0BEC5), // Màu primary pastel
            dividerColor: const Color(0xFFD1D9E6), // Màu divider pastel
            disabledColor: Colors.grey[400], // Màu disabled
            cardColor: Colors.white, // Màu card trắng
            canvasColor: const Color(0xFFFAFAFA), // Màu nền cho canvas
            brightness: Brightness.light,
            appBarTheme: const AppBarTheme(
              color: Color(0xFFFFFFFF), // Màu nền cho AppBar
            ),
            buttonTheme: Theme.of(context)
                .buttonTheme
                .copyWith(colorScheme: const ColorScheme.light()),
            textTheme: const TextTheme(
              bodyLarge:
                  TextStyle(color: Color(0xFF212121)), // Text màu xám đen
              bodyMedium:
                  TextStyle(color: Color(0xFF757575)), // Text màu xám nhạt
              displayLarge:
                  TextStyle(color: Color(0xFF42A5F5)), // Màu xanh dương nhạt
              titleLarge: TextStyle(color: Color(0xFFAB47BC)), // Màu tím nhạt
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Color(0xFFFF4081), // Màu hồng neon
            ),
            // toggleableActiveColor: const Color(0xFF7C4DFF), // Màu tím neon
          );
  }
}
