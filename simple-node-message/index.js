const http = require('http');

http.createServer((req, res) => {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end(process.env.MESSAGE || 'default message')
}).listen(process.env.PORT || 3000);