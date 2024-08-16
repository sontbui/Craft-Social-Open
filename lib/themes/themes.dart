import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyTheme {
  static ThemeData themeData(
      {required bool isDarkTheme, required BuildContext context}) {
    return isDarkTheme
        ? ThemeData(
            fontFamily: 'RedditMono-Bold',
            scaffoldBackgroundColor: const Color.fromARGB(255, 194, 193, 193),
            primarySwatch: Colors.grey,
            primaryColorDark: const Color.fromARGB(255, 141, 141, 141),
            dividerColor: Colors.white,
            disabledColor: Colors.grey,
            cardColor: const Color(0xFF444654),
            canvasColor: const Color.fromARGB(255, 175, 175, 175),
            brightness: Brightness.dark,
            appBarTheme: const AppBarTheme(
              color: Color.fromARGB(255, 175, 175, 175),
            ),
            buttonTheme: Theme.of(context)
                .buttonTheme
                .copyWith(colorScheme: const ColorScheme.dark()),
          )
        : ThemeData(
            fontFamily: 'RedditMono-Bold',
            scaffoldBackgroundColor: const Color.fromARGB(255, 208, 207, 207),
            primarySwatch: Colors.grey,
            primaryColorDark: const Color.fromARGB(255, 166, 164, 164),
            dividerColor: const Color.fromARGB(255, 114, 114, 114),
            disabledColor: Colors.grey,
            cardColor: Colors.white,
            canvasColor: Colors.grey[50],
            brightness: Brightness.light,
            appBarTheme: const AppBarTheme(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            buttonTheme: Theme.of(context)
                .buttonTheme
                .copyWith(colorScheme: const ColorScheme.light()),
          );
  }
}
