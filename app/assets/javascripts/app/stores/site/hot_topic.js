/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');
var SiteNetworkingActions = require('../../actions/networking/site');

var _hotTopics = [];

var HotTopicStore = Reflux.createStore({
    
    listenables: SiteNetworkingActions,
    
    init: function() {
    },

    onUpdateInitialData: function(data) {
        _hotTopics = data.hot_topics;
        this.trigger(_hotTopics);
        console.log(_hotTopics);
    },

    get: function() {
        return _hotTopics;
    }
    
});

module.exports = HotTopicStore;