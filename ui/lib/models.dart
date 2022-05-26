class Song {
  final String id;
  final String name;
  final String artist;
  final String genre;
  final String rawSongId;

  // Song(this._id, this.name, this.artist, this.genre, this.rawSongId);
  Song({
    required this.id,
    required this.name,
    required this.artist,
    required this.genre,
    required this.rawSongId
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['_id'],
      name: json['name'],
      artist: json['artist'],
      genre: json['genre'],
      rawSongId: json['rawSongId']
    );
  }
}

class Playlist {
  final String name;
  final String description;
  final List<Song> songs;

  Playlist({
    required this.name,
    required this.description,
    required this.songs
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    List<Song> songs = [];

    for (var jsonSong in json['songs']) {
      songs.add(Song.fromJson(jsonSong));
    }

    return Playlist(
        name: json['name'],
        description: json['description'],
        songs: songs,
    );
  }
}