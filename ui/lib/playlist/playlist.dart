import 'package:flutter/material.dart';
import 'package:spotify/theme/colors.dart';
import '../assets/assets.dart';
import '../utils/icon.dart';

class Playlist extends StatelessWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          SizedBox(height: 128),
          PlaylistInfo(),
          PlaylistList(),
        ],
      ),
    );
  }

}

class PlaylistInfo extends StatelessWidget {
  const PlaylistInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          Image.asset(Assets.demo, width: 240, height: 240),
          SizedBox(height: 24),
          Text('Playlist name', style: const TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Text('Made for User', style: const TextStyle(fontWeight: FontWeight.bold, color: ThemeColors.fontDarker, fontSize: 12)),
          Text('Stats', style: const TextStyle(fontWeight: FontWeight.bold, color: ThemeColors.fontDarker, fontSize: 12)),
        ],
      ),
    );
  }

}

class PlaylistList extends StatelessWidget {
  const PlaylistList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          PlaylistItem(),
          SizedBox(height: 16),
          PlaylistItem(),
          SizedBox(height: 16),
          PlaylistItem(),
          SizedBox(height: 16),
          PlaylistItem(),
        ],
      ),
    );
  }

}

class PlaylistItem extends StatelessWidget {
  const PlaylistItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge, // overflow hidden
      decoration: BoxDecoration(
        // color: ThemeColors.cardColor,
        // borderRadius: BorderRadius.circular(4),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Image.asset(Assets.demo, width: 48, height: 48),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text('Song title', style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('Song artist', style: const TextStyle(fontWeight: FontWeight.bold, color: ThemeColors.fontDarker, fontSize: 12)),
            ],
          ),
          Spacer(),
          AppIcon(Assets.hearthFilled),
          SizedBox(width: 16),
        ],
      ),
    );
  }

}