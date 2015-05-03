/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');
var TopicNetworkingActions = require('../../actions/networking/topic');

var _topic = {};

var CurrentTopicStore = Reflux.createStore({

    listenables: TopicNetworkingActions,

    init: function () {
    },

    onReceivedSingle: function (data) {
        _topic = data;
        this.trigger(_topic);
    },

    get: function() {
        return _topic;
    }

});

module.exports = CurrentTopicStore;