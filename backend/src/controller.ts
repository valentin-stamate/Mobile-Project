import {NextFunction, Request, Response,} from "express";
import {Service} from "./service";
require('dotenv').config();

export class Controller {

    static async hello(req: Request<any>, res: Response, next: NextFunction) {
        res.contentType('text/plain');
        res.end(await Service.hello());
    }

}