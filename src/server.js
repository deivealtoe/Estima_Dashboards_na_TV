const express = require('express');
const cors = require('cors');

const server = express();

server.use(express.json());
server.use(express.urlencoded({ extended: false }));
server.use(cors());

server.use('/api', require('./_routes/router'));

const PORT = 3000;

server.listen(PORT, () => {
    console.log(`Server iniciado na porta ${PORT}`);
});