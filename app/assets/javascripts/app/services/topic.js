var Client = require('../utilities/client');

module.exports = {
    getList: function(nodeSlug, page) {

    },

    getDefaultList: function(page) {
        page = page || 1;
        return Client.get('topics/list').query({page: page});
    }
};

