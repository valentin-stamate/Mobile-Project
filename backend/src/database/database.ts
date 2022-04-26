import {Db, MongoClient} from "mongodb";
require('dotenv').config();

const env = process.env;

const dbName = env.DB_NAME as string;
const uri = env.DB_URI as string;
const client = new MongoClient(uri);

export let database: Db = {} as Db;

export async function connectToMongo() {
    try {
        await client.connect();
        database = client.db(dbName);

        console.log('Successfully connected with the MongoDB');
    } catch (err) {
        console.log(err);
    }
}

export enum MongoCollection {
    USERS = 'users',
    SONGS = 'songs',
    PLAYLISTS = 'playlists',
}
