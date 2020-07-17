const express = require('express');
const midConsoleLog = require('./_middlewares/console_log');

const router = express.Router();

router.use('/fabricante', midConsoleLog, require('./fabricante'));

router.use('/vendedor', midConsoleLog, require('./vendedor'));

module.exports = router;