import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const backgroundColor = Color(0xFF121212); // #121212
const transparent = Color.fromRGBO(0, 0, 0, 0);

var spotifyTheme = ThemeData(
  backgroundColor: backgroundColor,
  scaffoldBackgroundColor: backgroundColor,
  dialogBackgroundColor: backgroundColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: backgroundColor,
    shadowColor: transparent,
    toolbarHeight: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      systemNavigationBarColor: backgroundColor,
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