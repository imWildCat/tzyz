var Client = require('../utilities/client');

module.exports = {

    getSingle: function(id, page) {
        page = page || 1;
        return Client.get('topics/' + parseInt(id)).query({page: page});
    },

    getList: function(nodeSlug, page) {

    },

    getDefaultList: function(page) {
        page = page || 1;
        return Client.get('topics/list').query({page: page});
    }
};

