var Client = require('../utilities/client');

module.exports = {


    getInitialData: function() {
        return Client.get('site/init');
    }
};
