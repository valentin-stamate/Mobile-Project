import {Collections, database} from "../database/database";
import {Playlist, PlaylistSong, PlaylistSongs, RawSong, Song, User, UserSong} from "./models";
import {ResponseError} from "./middleware";
import {ResponseMessage, StatusCode} from "./rest.utils";
import {JwtService} from "./jwt.service";
import {UploadedFile} from "express-fileupload";
import {ObjectId} from "mongodb";

export class Service {

    static async getPlaylistSongs(playlistId: ObjectId) {
        const playlistSongsCollection = database.collection(Collections.PLAYLIST_SONGS);
        const songCollection = database.collection(Collections.SONG);

        const playlistSongs = (await playlistSongsCollection.find({playlistId: playlistId}).toArray()) as PlaylistSong[];

        const songs: Song[] = [];

        for (let item of playlistSongs) {
            const song = (await songCollection.findOne({_id: item.songId})) as Song;
            songs.push(song);
        }

        return songs;
    }

    static async removeUserSong(userId: ObjectId, songId: ObjectId) {
        const userSongsCollection = database.collection(Collections.USER_SONGS);

        const existingUserSong = await userSongsCollection.findOne({userId: userId, songId: songId});

        if (!existingUserSong) {
            throw new ResponseError(ResponseMessage.SONG_NOT_FOUND, StatusCode.NOT_FOUND);
        }

        await userSongsCollection.deleteOne({userId: userId, songId: songId});
    }

    static async addUserSong(userId: ObjectId, songId: ObjectId) {
        const userSongsCollection = database.collection(Collections.USER_SONGS);

        const userSong: UserSong = {
            userId: userId,
            songId: songId,
        };

        const existingUserSong = await userSongsCollection.findOne(userSong);

        if (existingUserSong) {
            throw new ResponseError(ResponseMessage.SONG_ALREADY_IN_FAVORITES, StatusCode.NOT_FOUND);
        }


        await userSongsCollection.insertOne(userSong);
    }

    static async getUserSongs(userId: ObjectId) {
        const userSongsCollection = database.collection(Collections.USER_SONGS);
        const songCollection = database.collection(Collections.SONG);

        const userSongs = (await userSongsCollection.find({userId: userId}).toArray()) as UserSong[];
        const songs: Song[] = [];

        for (let item of userSongs) {
            const song = (await songCollection.findOne({_id: item.songId})) as Song;
            songs.push(song);
        }

        return songs;
    }

    static async getSong(songId: ObjectId): Promise<RawSong> {
        const rawSongCursor = database.collection(Collections.RAW_SONGS);

        const rawSong = await rawSongCursor.findOne({_id: songId}) as RawSong;

        if (!rawSong) {
            throw new ResponseError(ResponseMessage.SONG_NOT_FOUND, StatusCode.NOT_FOUND);
        }

        return rawSong;
    }

    static async addSongToPlaylist(songId: ObjectId, playlistId: ObjectId) {
        const playlistCollection = database.collection(Collections.PLAYLISTS);
        const playlistSongCollection = database.collection(Collections.PLAYLIST_SONGS);
        const songCollection = database.collection(Collections.SONG);

        const existingPlaylist = await playlistCollection.findOne({_id: playlistId});
        const existingSong = await songCollection.findOne({_id: songId});

        const existingPlaylistSong = await playlistSongCollection.findOne({songId: songId, playlistId: playlistId});

        if (existingPlaylistSong) {
            throw new ResponseError(ResponseMessage.SONG_ALREADY_IN_PLAYLIST, StatusCode.BAD_REQUEST);
        }

        if (!existingPlaylist) {
            throw new ResponseError(ResponseMessage.PLAYLIST_NOT_FOUND, StatusCode.NOT_FOUND);
        }

        if (!existingSong) {
            throw new ResponseError(ResponseMessage.SONG_NOT_FOUND, StatusCode.NOT_FOUND);
        }

        const playlistSong: PlaylistSong = {
            playlistId: existingPlaylist._id,
            songId: existingSong._id,
        }

        await playlistSongCollection.insertOne(playlistSong);
    }

    static async getPlaylists(): Promise<any> {
        const playlistCollection = database.collection(Collections.PLAYLISTS);
        const playlistSongsCursor = await database.collection(Collections.PLAYLIST_SONGS);
        const songCursor = await database.collection(Collections.SONG);

        const playlistsCursor = await playlistCollection.find();
        const playlists = (await playlistsCursor.toArray()) as Playlist[];

        const playlistList: PlaylistSongs[] = [];

        for (let item of playlists) {
            const playlistSongList = ((await playlistSongsCursor.find({playlistId: item._id}).toArray()) as PlaylistSong[]);

            const fullSongListDetails: Song[] = [];

            for (let item of playlistSongList) {
                fullSongListDetails.push((await songCursor.findOne({_id: item.songId})) as Song);
            }

            const fullPlaylist: PlaylistSongs = {...item, songs: fullSongListDetails};
            playlistList.push(fullPlaylist);
        }

        return playlistList;
    }

    static async addPlaylist(playlist: Playlist) {
        const playlistCursor = database.collection(Collections.PLAYLISTS);

        await playlistCursor.insertOne(playlist);
    }

    static async addSong(song: Song, songBuffer: UploadedFile) {
        const songCollection = database.collection(Collections.SONG);
        const rawSongCollection = database.collection(Collections.RAW_SONGS);

        const inserted = await rawSongCollection.insertOne({
            binaries: songBuffer.data,
        });

        const rawSong = await rawSongCollection.findOne({_id: inserted.insertedId});

        if (!rawSong ||  !rawSong._id) {
            throw new ResponseError(ResponseMessage.SOMETHING_WRONG);
        }

        song.rawSongId = rawSong._id;
        await songCollection.insertOne(song);
    }

    static async getSongs(): Promise<Song[]> {
        const songCollection = database.collection(Collections.SONG);
        const songsCursor = await songCollection.find();

        return (await songsCursor.toArray()) as Song[];
    }

    static async login(user: User): Promise<string> {
        const userCollection = database.collection(Collections.USER);

        const existingUser = (await userCollection.findOne({username: user.username})) as User;

        if (!existingUser) {
            throw new ResponseError(ResponseMessage.USER_NOT_FOUND, StatusCode.BAD_REQUEST);
        }

        if (existingUser.password !== user.password) {
            throw new ResponseError(ResponseMessage.INVALID_PASSWORD, StatusCode.BAD_REQUEST);
        }

        return JwtService.generateAccessToken(existingUser);
    }

    static async register(user: User): Promise<void> {
        const userCollection = database.collection(Collections.USER);

        const existingUser = await userCollection.findOne({username: user.username});

        if (existingUser) {
            throw new ResponseError(ResponseMessage.USER_ALREADY_EXISTS, StatusCode.BAD_REQUEST);
        }

        await userCollection.insertOne(user);
    }
}