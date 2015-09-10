/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');
var SiteNetworkingActions = require('../../actions/networking/site');

var _hotNodes = [];

var HotNodeStore = Reflux.createStore({

    listenables: SiteNetworkingActions,

    init: function() {
    },

    onUpdateInitialData: function(data) {
        _hotNodes = data.hot_nodes;
        this.trigger(_hotNodes);
    },

    get: function() {
        return _hotNodes;
    }

});

module.exports = HotNodeStore;