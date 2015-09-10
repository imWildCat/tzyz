/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');
var SiteNetworkingActions = require('../../actions/networking/site');

var _topics = [];

var TopicListStore = Reflux.createStore({

    listenables: SiteNetworkingActions,

    init: function() {
    },

    onUpdateInitialData: function(data) {
        _topics = data.topics;
        this.trigger(_topics);
    },

    get: function() {
        return _topics;
    }

});

module.exports = TopicListStore;