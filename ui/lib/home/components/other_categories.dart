import 'package:flutter/material.dart';
import 'package:spotify/assets/assets.dart';
import 'package:spotify/home/components/frequent_playlists.dart';
import 'package:spotify/models.dart';
import 'package:spotify/theme/colors.dart';
import 'package:spotify/utils/icon.dart';

class FrequentCategories extends StatelessWidget {
  const FrequentCategories({Key? key}) : super(key: key);

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
            'Other Categories',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
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
              children: [
                PlaylistItem(playlist: new Playlist(name: 'Category A', description: 'Category A songs', songs: []),),
                SizedBox(height: 8),
              ],
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              children: [
                PlaylistItem(playlist: new Playlist(name: 'Category B', description: 'Category B songs', songs: []),),
                SizedBox(height: 8),
              ],
            ),
          ),
        ]
    );
  }

}