import 'package:flutter/material.dart';
import 'package:spotify/home/components/frequent_playlists.dart';
import 'package:spotify/home/components/made_for.dart';
import 'package:spotify/liked_songs/liked_songs.dart';
import 'components/other_categories.dart';

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
          SizedBox(height: 8),
          FrequentCategories(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Your library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle),
            label: 'Playlists',
          ),
        ],
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.black12,
        onTap: (index) => {
          if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LikedSongsWidget()))
          }
        },
      ),
    );
  }

}