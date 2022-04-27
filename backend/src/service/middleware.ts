import {NextFunction, Request, Response,} from "express";
import {ResponseMessage, StatusCode} from "./rest.utils";
import {JwtService} from "./jwt.service";
import {Collections, database} from "../database/database";
import {User} from "./models";
import {ObjectId} from "mongodb";
require('dotenv').config();

const env = process.env;

export class Middleware {

    /** Middleware for unauthorized users. In this case every request can pass. */
    static async visitorMiddleware (req: Request<any>, res: Response, next: NextFunction) {
        res.setHeader('Content-Type', 'application/json');
        next();
    }

    static async userMiddleware(req: Request<any>, res: Response, next: NextFunction) {
        const token = req.get('Authorization') as string;

        if (!token) {
            next(new ResponseError(ResponseMessage.AUTHORIZATION_MISSING));
            return;
        }

        const user = JwtService.verifyToken(token) as User;
        user._id = new ObjectId(user._id);

        const userCollection = database.collection(Collections.USER);
        const existingUser = await userCollection.findOne({_id: user._id});

        if (!existingUser) {
            next(new ResponseError(ResponseMessage.USER_NOT_FOUND, StatusCode.NOT_FOUND));
            return;
        }

        res.setHeader('Content-Type', 'application/json');
        next();
    }

    static async adminMiddleware(req: Request<any>, res: Response, next: NextFunction) {
        const secretKey = req.get('Authorization');
        const adminKey = env.ADMIN_KEY;

        if (secretKey !== adminKey) {
            next(new ResponseError(ResponseMessage.ADMIN_ACCESS_ONLY, StatusCode.UNAUTHORIZED));
            return;
        }

        res.setHeader('Content-Type', 'application/json');
        next();
    }

    /** The middleware that handles all the exceptions thrown by the app */
    static errorHandler(err: ResponseError, req: Request<any>, res: Response, next: NextFunction) {
        let statusError = 500;

        if (err.status !== undefined) {
            statusError = err.status;
        }

        console.log(err);
        res.setHeader('Content-Type', 'text/plain');
        res.status(statusError).send(err.message);
    }
}

export class ResponseError extends Error {
    constructor(public message: string, public status: number = 500) {
        super(message);
    }
}