const http = require('http');
const MongoClient = require('mongodb').MongoClient;
const url = `mongodb://root:secret@localhost:27017`

const PORT = process.env.PORT || 3000;

const DB_OPTIONS = {
    useNewUrlParser: true,
    useUnifiedTopology: true,
};

const DB_CONNECTION_PARAMETERS = {
    reconnectTries: 2,
    reconnectInterval: 500
}

http.createServer(async(req, res) => {
    let client;
    try {
        client = await MongoClient.connect(url, DB_OPTIONS, DB_CONNECTION_PARAMETERS);
        const db = client.db('data');
        const collection = db.collection('stories');
        try {
            const items = await collection.find().toArray();
            res.writeHead(200, { 'Content-Type': 'text/html' });
            res.end(JSON.stringify(items));
        } catch (err) {
            res.writeHead(403);
            res.end('Not enough permissions');
        }
    } catch (err) {
        console.error(err);
        res.writeHead(500);
        res.end('Error occured: ', err);
    } finally {
        await client.close();
    }
}).listen(PORT, () => console.log('server started on ' + PORT));
