import express = require("express");
import cors from 'cors';
import helmet from 'helmet';
import morgan from "morgan";
import fileUpload from "express-fileupload";
import {connectToMongo} from "./database/database";
import {Endpoints} from "./service/endpoints";
import {Middleware} from "./service/middleware";
import {Controller} from "./controller/controller";

require('dotenv').config();
const env = process.env;

const app = express();
const port = env.PORT;
const host = `http://localhost:${port}`

connectToMongo().catch(err => {
    console.log(err);
});

/************************************************************************************
 *                              Basic Express Middlewares
 ***********************************************************************************/
app.use(morgan('dev'));
app.use(express.urlencoded({extended: true}));
app.use(express.json());
app.use(fileUpload());
app.set('json spaces', 4);

// Handle logs in console during development
if (process.env.NODE_ENV === 'development' || env.NODE_ENV === 'development') {
    app.use(cors({origin: '*'}));
}

// Handle security and origin in production
if (process.env.NODE_ENV === 'production' || env.NODE_ENV === 'production') {
    app.use(helmet());
}

/************************************************************************************
 *                               Register all REST routes
 ***********************************************************************************/
app.post(Endpoints.REGISTER, Middleware.visitorMiddleware, Controller.register);
app.post(Endpoints.LOGIN, Middleware.visitorMiddleware, Controller.login);

app.get(Endpoints.PLAYLISTS, Middleware.userMiddleware, Controller.getPlaylists);
app.get(Endpoints.RAW_SONG, Middleware.userMiddleware, Controller.getSong);
app.get(Endpoints.USER_SONGS, Middleware.userMiddleware, Controller.getUserSongs);
app.post(Endpoints.USER_SONGS, Middleware.userMiddleware, Controller.addUserSong);
app.delete(Endpoints.USER_SONGS, Middleware.userMiddleware, Controller.removeUserSong);
app.get(Endpoints.PLAYLIST_SONG, Middleware.userMiddleware, Controller.getPlaylistSongs);

app.get(Endpoints.SONGS, Middleware.adminMiddleware, Controller.getSongs);
app.post(Endpoints.SONGS, Middleware.adminMiddleware, Controller.addSong);
app.post(Endpoints.PLAYLIST_SONG, Middleware.adminMiddleware, Controller.addSongToPlaylist);
app.post(Endpoints.PLAYLISTS, Middleware.adminMiddleware, Controller.addPlaylist);


/************************************************************************************
 *                               Express Error Handling
 ***********************************************************************************/
app.use(Middleware.errorHandler);

app.listen(port, () => {
    console.log(`Server started at ${host}`);
});