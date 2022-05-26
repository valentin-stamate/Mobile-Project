import 'package:flutter/material.dart';
import 'package:spotify/song_view.dart';
import 'package:spotify/theme/colors.dart';
import '../assets/assets.dart';
import '../models.dart';
import '../utils/icon.dart';

class PlaylistWidget extends StatelessWidget {
  final Playlist playlist;

  PlaylistWidget({Key? key, required this.playlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 128),
          PlaylistInfo(playlist: this.playlist),
          PlaylistList(songs: this.playlist.songs),
        ],
      ),
    );
  }

}

class PlaylistInfo extends StatelessWidget {
  final Playlist playlist;

  PlaylistInfo({Key? key, required this.playlist}) : super(key: key);

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
          Text(this.playlist.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Text(this.playlist.description, style: const TextStyle(fontWeight: FontWeight.bold, color: ThemeColors.fontDarker, fontSize: 12)),
        ],
      ),
    );
  }

}

class PlaylistList extends StatelessWidget {
  final List<Song> songs;

  PlaylistList({Key? key, required this.songs}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Widget> songWidgets = [];

    for (var song in this.songs) {
      songWidgets.add(PlaylistItem(song: song));
      songWidgets.add(SizedBox(height: 16,));
    }

    return Container(
      padding: const EdgeInsets.all(16),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: songWidgets,
      ),
    );
  }

}

class PlaylistItem extends StatelessWidget {
  final Song song;

  const PlaylistItem({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {

        Navigator.push(context, MaterialPageRoute(
            builder: (context) => SongViewWidget(song: this.song)
        ))

      },
      child: Container(
        clipBehavior: Clip.hardEdge, // overflow hidden
        decoration: const BoxDecoration(
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
                Text(this.song.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(this.song.artist, style: const TextStyle(fontWeight: FontWeight.bold, color: ThemeColors.fontDarker, fontSize: 12)),
              ],
            ),
            Spacer(),
            AppIcon(Assets.hearthFilled),
            SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

}