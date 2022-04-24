import 'package:flutter/material.dart';
import 'package:spotify/assets/assets.dart';
import 'package:spotify/theme/colors.dart';
import 'package:spotify/utils/icon.dart';

class FrequentPlaylists extends StatelessWidget {
  const FrequentPlaylists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: const [
          Intro(),
          SizedBox(height: 16),
          Playlists(),
        ],
      ),
    );
  }

}

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }

}

class Playlists extends StatelessWidget {
  const Playlists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Expanded(
            child: Column(
              children: const [
                PlaylistItem(title: 'One'),
                SizedBox(height: 8),
                PlaylistItem(title: 'Two'),
                SizedBox(height: 8),
                PlaylistItem(title: 'Three'),
              ],
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              children: const [
                PlaylistItem(title: 'One'),
                SizedBox(height: 8),
                PlaylistItem(title: 'Two'),
                SizedBox(height: 8),
                PlaylistItem(title: 'Three'),
              ],
            ),
          ),
        ]
    );
  }

}

class PlaylistItem extends StatelessWidget {
  final String title;

  const PlaylistItem({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge, // overflow hidden
      decoration: BoxDecoration(
        color: ThemeColors.cardColor,
        borderRadius: BorderRadius.circular(4),
      ),

      child: Row(
        children: [
          Image.asset(
            Assets.demo,
            width: 48,
            height: 48,
          ),
          SizedBox(width: 16),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

}