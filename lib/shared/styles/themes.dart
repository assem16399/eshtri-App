import 'package:eshtri/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final darkTheme = ThemeData(
  fontFamily: 'Ruda',
  scaffoldBackgroundColor: const Color(0XFF333739),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange)
      .copyWith(secondary: const Color(0XFF333739), onSecondary: Colors.white),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0XFF333739),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
    ),
    iconTheme: IconThemeData(color: Colors.white),
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Color(0XFF333739),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0XFF333739),
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
    showSelectedLabels: true,
  ),
  textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
      bodyText2: TextStyle(
        color: Colors.grey,
        fontSize: 15,
      )),
);

final lightTheme = ThemeData(
  fontFamily: 'Ruda',
  textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
      bodyText2: TextStyle(
        color: Colors.black,
        fontSize: 15,
      )),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: kPrimarySwatchColor)
      .copyWith(onSecondary: Colors.white),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
    ),
    iconTheme: IconThemeData(color: Colors.black),
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: kPrimarySwatchColor,
    unselectedItemColor: Colors.black,
    showUnselectedLabels: true,
    showSelectedLabels: true,
  ),
  scaffoldBackgroundColor: Colors.white,
);
