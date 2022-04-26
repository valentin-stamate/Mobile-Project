import express = require("express");
import cors from 'cors';
import helmet from 'helmet';
import morgan from "morgan";
import fileUpload from "express-fileupload";
import {connectToMongo} from "./database/database";
import {Endpoints} from "./endpoints";
import {Middleware} from "./middleware";
import {Controller} from "./controller";

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
app.get(Endpoints.HELLO, Middleware.visitorMiddleware, Controller.hello);

/************************************************************************************
 *                               Express Error Handling
 ***********************************************************************************/
app.use(Middleware.errorHandler);

app.listen(port, () => {
    console.log(`Server started at ${host}`);
});