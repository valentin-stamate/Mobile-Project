import 'package:flutter/material.dart';
import 'package:spotify/home/home.dart';
import 'package:spotify/playlist/playlist.dart';
import 'package:spotify/theme/theme.dart';

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
      home: const Playlist(),
    );
  }
}

