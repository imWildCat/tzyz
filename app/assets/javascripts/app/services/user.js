var Client = require('../utilities/client');

module.exports = {

    getSingle: function(id) {
        return Client.get('users/' + parseInt(id));
    }
};

