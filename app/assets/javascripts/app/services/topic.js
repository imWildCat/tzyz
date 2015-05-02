var Client = require('../utilities/client');

module.exports = {

    getSingle: function (id, page) {
        page = page || 1;
        return Client.get('topics/' + parseInt(id)).query({page: page});
    },

    getList: function (nodeSlug, page) {

    },

    getDefaultList: function (page) {
        page = page || 1;
        return Client.get('topics/list').query({page: page});
    },

    createTopic: function (nodeID, title, content) {
        return Client.post('topics/create').query({
            node_id: nodeID,
            title: title,
            content: content
        });
    },

    createReply: function(topicID, content, quotedReplyID) {
        return Client.post('topics/' + topicID + '/reply').query({
            content: content,
            quoted_reply_id: quotedReplyID
        });
    }

};

