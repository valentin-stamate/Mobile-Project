import {Binary, ObjectId} from "mongodb";

export interface User {
    _id?: ObjectId;

    username: string;
    password: string;
}

export interface UserSong {
    _id?: ObjectId;

    userId: ObjectId;
    songId: ObjectId;
}

export interface Song {
    _id?: ObjectId;

    name: string;
    artist: string;
    genre: string;
    rawSongId: ObjectId;
}

export interface RawSong {
    _id?: ObjectId;

    binaries: Binary;
}

export interface Playlist {
    _id?: ObjectId;

    name: string;
    description: string;
}

export interface PlaylistSongs extends Playlist {
    songs: Song[];
}

export interface PlaylistSong {
    _id?: ObjectId;

    playlistId: ObjectId;
    songId: ObjectId;
}

export interface UserSong {
    _id?: ObjectId;

    userId: ObjectId;
    songId: ObjectId;
}