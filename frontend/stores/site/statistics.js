/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');
var SiteNetworkingActions = require('../../actions/networking/site');

var _statistics = {user_count: '?', topic_count: '?', reply_count: '?'};

var StatisticsStore = Reflux.createStore({

    listenables: SiteNetworkingActions,

    init: function() {
    },

    onUpdateInitialData: function(data) {
        _statistics = data.statistics;
        this.trigger(_statistics);
    },

    get: function() {
        return _statistics;
    }

});

module.exports = StatisticsStore;