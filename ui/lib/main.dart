import 'package:flutter/material.dart';
import 'package:spotify/register/login.dart';
import 'package:spotify/register/register.dart';
import 'package:spotify/routes.dart';
import 'package:spotify/theme/theme.dart';

import 'home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: spotifyTheme,
      initialRoute: Routes.login,
      routes: {
        Routes.login: (context) => Login(),
        Routes.register: (context) => Register(),
        Routes.home: (context) => Home(),
      },
    );
  }
}

