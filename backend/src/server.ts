import express = require("express");
import {connectToMongo} from "./database/database";

const app = express();
const port = 8090;
const host = `http://localhost:${port}`

connectToMongo().catch(err => {
    console.log(err);
});

app.get('/', (req, res) => {
    res.end('Hello word!')
});

app.listen(port, () => {
    console.log(`Server started at ${host}`);
});