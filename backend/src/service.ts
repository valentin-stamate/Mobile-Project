import {NextFunction, Request, Response,} from "express";

export class Service {

    static async hello(): Promise<any> {
        return 'Hello world!';
    }
}