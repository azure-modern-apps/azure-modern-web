const { MongoClient } = require("mongodb");

const config = {
  dbName: "sampledatabase"
};

export async function createConnection() {
  const connection = await MongoClient.connect(process.env['CONNECTION_STRING'], {
    useNewUrlParser: true
  });
  const db = connection.db(config.dbName);
  return {
    connection,
    db
  };
}
