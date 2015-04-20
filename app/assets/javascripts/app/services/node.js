var Client = require('../utilities/client');

module.exports = {

    getSingle: function(slug, page) {
        page = page || 1;
        return Client.get('nodes/' +slug).query({page: page});
    }

};

