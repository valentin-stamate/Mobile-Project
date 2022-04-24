import 'package:flutter/material.dart';
import 'package:spotify/home/components/frequent_playlists.dart';
import 'package:spotify/home/components/made_for.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: const [
          SizedBox(height: 16),
          FrequentPlaylists(),
          SizedBox(height: 8),
          MadeFor(),
        ],
      ),
    );
  }

}