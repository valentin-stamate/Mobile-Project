import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify/store.dart';
import 'package:spotify/theme/colors.dart';
import 'assets/assets.dart';
import 'endpoints.dart';
import 'models.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';

class SongViewWidget extends StatefulWidget {
  final Song song;

  const SongViewWidget({Key? key, required this.song}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SongViewState(song: this.song);
  }

}

class _SongViewState extends State<SongViewWidget> {
  Future<String> fetchSongData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(StoreKey.token)!;

    var response;
    response = await http.get(Uri.parse('${Endpoints.song}/${this.song.rawSongId}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },);

    String songStrBytes = response.body;
    List<int> bytes = utf8.encode(songStrBytes);
    Uint8List uInt8list = Uint8List.fromList(bytes);

    AudioPlayer audioPlayer = AudioPlayer();
    // await
    audioPlayer.playBytes(uInt8list);

    /* Getting the liked songs */
    response = await http.get(Uri.parse(Endpoints.userSong),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },);

    var bodyJson = jsonDecode(response.body);

    var currentSong = this.song.id;
    for (var songJson in bodyJson) {
      Song song = Song.fromJson(songJson);

      if (currentSong == song.id) {
        return 'l';
      }
    }

    return 'n';
  }

  likeSong() async {
    debugPrint('Liking song');

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(StoreKey.token)!;

    var response = await http.post(Uri.parse('${Endpoints.userSong}/${this.song.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },);
  }

  dislikeSong() async {
    debugPrint('Disliking song');

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(StoreKey.token)!;

    var response = await http.delete(Uri.parse('${Endpoints.userSong}/${this.song.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },);
  }

  late Future<String> songBuffer;
  final Song song;

  _SongViewState({required this.song});

  @override
  void initState() {
    super.initState();
    this.songBuffer = fetchSongData();
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: FutureBuilder<String>(
      future: this.songBuffer,
      builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;

            Widget likeWidget = GestureDetector(
              onTap: likeSong,
              child: Icon(Icons.thumb_up_alt_outlined, size: 52, color: Colors.white,),
            );

            if (data == 'l') {
              likeWidget = GestureDetector(
                onTap: dislikeSong,
                child: Icon(Icons.thumb_down_alt_outlined, size: 52, color: Colors.white,),
              );
            }

            Widget icon = GestureDetector(
                child: Icon(Icons.play_arrow, size: 72, color: Colors.white,)
            );

            if (true) {
              icon = GestureDetector(
                  child: Icon(Icons.stop, size: 72, color: Colors.white,)
              );
            }

            return Scaffold(
              body: Container(
                padding: const EdgeInsets.all(16),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: [
                    Image.asset(Assets.demo, width: 240, height: 240),
                    SizedBox(height: 24),
                    Center(
                      child: Text(this.song.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 12),
                    Center(
                      child: Text(this.song.artist, style: const TextStyle(fontWeight: FontWeight.bold, color: ThemeColors.fontDarker, fontSize: 12)),
                    ),
                    Center(
                      child: icon,
                    ),
                    Center(
                      child: Text(true == true ? 'Playing' : 'Stoped'),
                    ),
                    SizedBox(height: 12,),
                    Center(
                      child: likeWidget,
                    ),
                  ],
                ),
              ),
            );
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }

}