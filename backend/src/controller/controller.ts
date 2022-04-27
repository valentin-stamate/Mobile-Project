import {NextFunction, Request, Response,} from "express";
import {Playlist, Song, User} from "../service/models";
import {Service} from "../service/service";
import {ResponseMessage, StatusCode} from "../service/rest.utils";
import {ResponseError} from "../service/middleware";
import {UploadedFile} from "express-fileupload";
import {ObjectId} from "mongodb";
import {JwtService} from "../service/jwt.service";
require('dotenv').config();

export class Controller {

    static async getPlaylistSongs(req: Request<any>, res: Response, next: NextFunction) {
        const body = req.body;
        const playlistId = body.playlistId;

        try {
            const songs = await Service.getPlaylistSongs(new ObjectId(playlistId));

            res.end(JSON.stringify(songs));
        } catch (err) {
            next(err);
        }
    }

    static async removeUserSong(req: Request<any>, res: Response, next: NextFunction) {
        const body = req.body;
        const token = req.get('Authorization') as string;
        const user = JwtService.verifyToken(token) as User;
        const songId = body.songId;

        try {
            await Service.removeUserSong(new ObjectId(user._id), new ObjectId(songId));

            res.statusCode = StatusCode.OK;
            res.end();
        } catch (err) {
            next(err);
        }
    }

    static async addUserSong(req: Request<any>, res: Response, next: NextFunction) {
        const body = req.body;
        const token = req.get('Authorization') as string;
        const user = JwtService.verifyToken(token) as User;
        const songId = body.songId;

        try {
            await Service.addUserSong(new ObjectId(user._id), new ObjectId(songId));

            res.statusCode = StatusCode.CREATED;
            res.end();
        } catch (err) {
            next(err);
        }
    }

    static async getUserSongs(req: Request<any>, res: Response, next: NextFunction) {
        const body = req.body;
        const token = req.get('Authorization') as string;
        const user = JwtService.verifyToken(token) as User;

        try {
            const songs = await Service.getUserSongs(new ObjectId(user._id));

            res.end(JSON.stringify(songs));
        } catch (err) {

        }
    }

    static async getSong(req: Request<any>, res: Response, next: NextFunction) {
        const body = req.body;
        const rawSongId = body.rawSongId;

        try {
            const rawSong = await Service.getSong(new ObjectId(rawSongId));
            const buffer = rawSong.binaries.buffer;

            res.contentType('audio/mpeg');
            res.end(buffer);
        } catch (err) {
            next(err);
        }
    }

    static async addSongToPlaylist(req: Request<any>, res: Response, next: NextFunction) {
        const body = req.body;
        const songId = body.songId as string;
        const playlistId = body.playlistId as string;

        try {
            await Service.addSongToPlaylist(new ObjectId(songId), new ObjectId(playlistId));

            res.end();
        } catch (err) {
            next(err);
        }

    }

    static async getPlaylists(req: Request<any>, res: Response, next: NextFunction) {
        try {
            const playlists = await Service.getPlaylists();

            res.end(JSON.stringify(playlists));
        } catch (err) {
            next(err);
        }
    }

    static async addPlaylist(req: Request<any>, res: Response, next: NextFunction) {
        const body = req.body as Playlist;

        try {
            await Service.addPlaylist(body);

            res.statusCode = StatusCode.CREATED;
            res.end();
        } catch (err) {
            next(err);
        }
    }

    static async addSong(req: Request<any>, res: Response, next: NextFunction) {
        const body = req.body as Song;

        if (!req.files) {
            next(new ResponseError(ResponseMessage.INCOMPLETE_FORM, StatusCode.BAD_REQUEST));
            return;
        }

        const file = req.files.binaries as UploadedFile;

        if (!file) {
            next(new ResponseError(ResponseMessage.INCOMPLETE_FORM, StatusCode.BAD_REQUEST));
            return;
        }

        try {
            await Service.addSong(body, file);

            res.end();
        } catch (err) {
            next(err);
        }
    }

    static async getSongs(req: Request<any>, res: Response, next: NextFunction) {
        try {
            const songs = await Service.getSongs();

            res.end(JSON.stringify(songs));
        } catch (err) {
            next(err);
        }
    }

    static async login(req: Request<any>, res: Response, next: NextFunction) {
        const body = req.body;

        const user: User = {
            username: body.username,
            password: body.password,
        }

        try {
            const token = await Service.login(user);

            res.end(token);
        } catch (err) {
            next(err);
        }
    }

    static async register(req: Request<any>, res: Response, next: NextFunction) {
        const body = req.body;

        const user: User = {
            username: body.username,
            password: body.password,
        }

        try {
            await Service.register(user);

            res.statusCode = StatusCode.CREATED;
            res.end();
        res.end('');
        } catch (err) {
            next(err);
        }
    }

}