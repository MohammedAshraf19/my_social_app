import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/shared/compnents/constants.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.light,
  primaryColor: defaultColor,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
        color: Colors.black
    ),
    elevation: 0,
    backgroundColor: Colors.white,
    backwardsCompatibility: false,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
      size: 40,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor:uId!=null?Colors.white:defaultColor[400],
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: defaultColor,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey
  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
          fontWeight:FontWeight.bold ,
          fontSize: 20,
          color: Colors.black
      ),
      subtitle1: TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w600
      ),
    subtitle2: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        height:1.2
    ),
  ),
  cardColor: Colors.white,
);
ThemeData darkTheme =  ThemeData(
    scaffoldBackgroundColor: HexColor('333739'),
   // brightness: Brightness.dark,
    primaryColor: defaultColor,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
          color: Colors.white
      ),
      elevation: 0,
      backgroundColor: HexColor('333739'),
      backwardsCompatibility: false,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      textTheme: TextTheme(
          bodyText1: TextStyle(
              fontWeight:FontWeight.bold ,
              fontSize: 25,
              color: Colors.white
          ),
          subtitle1: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w600
          )
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.white,
        size: 40,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: uId!=null?Colors.black:defaultColor[400],
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: defaultColor,
        type: BottomNavigationBarType.fixed,
        backgroundColor: HexColor('333739'),
        unselectedItemColor: Colors.grey
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontWeight:FontWeight.bold ,
            fontSize: 20,
            color: Colors.white
        ),
        subtitle1: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w700
        ),
      caption: TextStyle(
        color: Colors.white54,
      ),
      subtitle2: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          height:1.2
      ),
    ),
  cardColor: HexColor('333739'),


);