const moment = require('moment');

module.exports = (request, response, next) => {

    console.log(`Acesso de: ${request.protocol}://${request.get('host')}${request.originalUrl} - Em: ${moment().format()}`);
    
    next();
};