import jwt from 'jsonwebtoken';
import {User} from "./models";

require('dotenv').config();
const env = process.env as any;
const tokenSecret = env.TOKEN_SECRET;

export class JwtService {

    static generateAccessToken(user: User) {
        return jwt.sign({
                _id: user._id,
                username: user.username,
            },
            tokenSecret);
    }

    static verifyToken(token: string): any {
        try {
            return jwt.verify(token, tokenSecret);
        } catch (e) {
            return null;
        }
    }

}