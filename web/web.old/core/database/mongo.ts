import { Db } from "mongodb";
const MongoClient = require('mongodb').MongoClient;

export async function createConnection() {
    const connection = await MongoClient.connect(process.env['CONNECTION_STRING'], {
        useNewUrlParser: true,
        useUnifiedTopology: true,
        useCreateIndex: true
    });
    const db: Db = connection.db('sampledatabase');
    return { connection, db };
}
