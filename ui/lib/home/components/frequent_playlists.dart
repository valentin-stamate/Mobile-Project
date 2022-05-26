import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify/assets/assets.dart';
import 'package:spotify/playlist/playlist.dart';
import 'package:spotify/theme/colors.dart';
import 'package:spotify/utils/icon.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../endpoints.dart';
import '../../models.dart';
import '../../store.dart';

class FrequentPlaylists extends StatefulWidget {
  const FrequentPlaylists({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FrequentPlaylistsState();
  }

}

class _FrequentPlaylistsState extends State<FrequentPlaylists> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          Row(
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
          ),
          SizedBox(height: 16),
          Playlists(),
        ],
      ),
    );
  }

}

class Playlists extends StatefulWidget {
  const Playlists({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PlaylistsState();
  }

}

class _PlaylistsState extends State<Playlists> {
  Future<List<Playlist>> fetchPlaylists() async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(StoreKey.token)!;

    var response = await http.get(Uri.parse(Endpoints.playlists),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        });

    final json = jsonDecode(response.body);

    List<Playlist> playlists = [];

    for (var jsonPlaylist in json) {
      playlists.add(Playlist.fromJson(jsonPlaylist));
    }

    return playlists;
  }

  late Future<List<Playlist>> playlistsFuture;

  @override
  void initState() {
    super.initState();
    playlistsFuture = fetchPlaylists();
  }

  @override
  Widget build(BuildContext context) {

    return Center(
          child: FutureBuilder<List<Playlist>>(
            future: playlistsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Playlist> playlists = snapshot.data!;

                List<Playlist> firstHalf = [];
                List<Playlist> secondHalf = [];

                var i = 0;
                for (Playlist playlist in playlists) {
                  if (i % 2 == 0) {
                    firstHalf.add(playlist);
                  } else {
                    secondHalf.add(playlist);
                  }

                  i++;
                }

                List<Widget> firstColumn = [];
                List<Widget> secondColumn = [];

                for (Playlist playlist in firstHalf) {
                  firstColumn.add(PlaylistItem(playlist: playlist));
                  firstColumn.add(SizedBox(height: 8));
                }

                for (Playlist playlist in secondHalf) {
                  secondColumn.add(PlaylistItem(playlist: playlist));
                  secondColumn.add(SizedBox(height: 8));
                }

                return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Expanded(
                          child: Column(
                            children: firstColumn,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            children: secondColumn,
                          ),
                        ),
                      ]
                  );
              }

              return const CircularProgressIndicator();
            },
          ),
      );
  }
}

class PlaylistItem extends StatelessWidget {
  final Playlist playlist;

  const PlaylistItem({Key? key, required this.playlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => PlaylistWidget(playlist: this.playlist)
        ))
      },
      child: Container(
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
            Text(this.playlist.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

}