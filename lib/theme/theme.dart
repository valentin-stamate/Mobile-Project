import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

var spotifyTheme = ThemeData(
  backgroundColor: ThemeColors.backgroundColor,
  scaffoldBackgroundColor: ThemeColors.backgroundColor,
  dialogBackgroundColor: ThemeColors.backgroundColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: ThemeColors.backgroundColor,
    shadowColor: ThemeColors.transparent,
    toolbarHeight: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      systemNavigationBarColor: ThemeColors.backgroundColor,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: null,
      // statusBarColor: Color(0xFFD59898),
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Colors.white,),
    bodyText2: TextStyle(color: Colors.white,)
  )
);