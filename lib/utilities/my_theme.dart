///
/// A cutom [Theme] for :
/// light mode - dark mode - fonts - colors

import 'package:flutter/material.dart';

class MyTheme {
  ///* Colors
  static Color primaryColor = const Color(0xFF5D9CEC);
  static Color lightBackgroundColor = const Color(0xFFDFECDB);
  static Color darkBackgroundColor = const Color(0xFF060E1E);
  static Color greyLightColor = const Color(0xFFC8C9CB);
  static Color greyDarkColor = const Color(0xFF707070);
  static Color whiteColor = const Color(0xFFFFFFFF);
  static Color blackColor = const Color(0xFF363636);
  static Color petrolColor = const Color(0xFF141922);
  static Color greenColor = const Color(0xFF61E757);
  static Color redColor = const Color(0xFFEC4B4B);

  ///* LightMode Theme: -
  static ThemeData lightMode = ThemeData(
    scaffoldBackgroundColor: lightBackgroundColor,
    primaryColor: primaryColor,
    useMaterial3:
        false, // Solved the issue of clicking on the the whole `NavBar`

    ///* AppBarTheme
    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      foregroundColor: whiteColor,
      backgroundColor: primaryColor,
    ),

    ///* FloatingActionButtonThemeData
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: whiteColor,
        iconSize: 33,
        shape: StadiumBorder(side: BorderSide(width: 4, color: whiteColor))),

    ///* BottomNavigationBarThemeData
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.transparent,
        selectedIconTheme: IconThemeData(
          size: 33,
          color: primaryColor,
        ),
        unselectedIconTheme: IconThemeData(
          size: 33,
          color: greyLightColor,
        )),

    ///* BottomSheetThemeData
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
    ),

    ///* TextTheme
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontFamily: "Poppins",
        color: whiteColor,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        fontFamily: "Poppins",
        color: blackColor,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      titleSmall: TextStyle(
        fontFamily: "Poppins",
        color: greyDarkColor,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    ),
  );

  ///* DarkMode Theme: -
  static ThemeData darkMode = ThemeData(
    scaffoldBackgroundColor: darkBackgroundColor,
    primaryColor: primaryColor,
    primaryColorDark: darkBackgroundColor,
    useMaterial3:
        false, // Solved the issue of clicking on the the whole `NavBar`

    ///* AppBarTheme
    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      foregroundColor: darkBackgroundColor,
      backgroundColor: primaryColor,
    ),

    ///* FloatingActionButtonThemeData
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: whiteColor,
        iconSize: 33,
        shape: StadiumBorder(
            side: BorderSide(
          width: 4,
          color: petrolColor,
        ))),

    ///* BottomNavigationBarThemeData
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.transparent,
        selectedIconTheme: IconThemeData(
          size: 33,
          color: primaryColor,
        ),
        unselectedIconTheme: IconThemeData(
          size: 33,
          color: whiteColor,
        )),

    ///* BottomSheetThemeData
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
    ),

    ///* TextTheme
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontFamily: "Poppins",
        color: petrolColor,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        fontFamily: "Poppins",
        color: whiteColor,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      titleSmall: TextStyle(
        fontFamily: "Poppins",
        color: greyLightColor,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
