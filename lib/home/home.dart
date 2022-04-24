import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotify/home/components/intro.dart';

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
          Intro()
        ],
      ),
    );
  }

}