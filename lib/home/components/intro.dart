import 'package:flutter/material.dart';
import 'package:spotify/assets/assets.dart';
import 'package:spotify/utils/icon.dart';

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: const [
          Text(
            'Good afternoon',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          AppIcon(Assets.bellSolid),
          SizedBox(width: 16),
          AppIcon(Assets.settings),
          SizedBox(width: 16),
          AppIcon(Assets.clockRotate),
        ]
      )
    );
  }

}