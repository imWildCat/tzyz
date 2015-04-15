/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');
var SiteNetworkingActions = require('../../actions/networking/site');

var _newNodes = [];

var NewNodeStore = Reflux.createStore({

    listenables: SiteNetworkingActions,

    init: function() {
    },

    onUpdateInitialData: function(data) {
        _newNodes = data.new_nodes;
        this.trigger(_newNodes);
        console.log(_newNodes);
    },

    get: function() {
        return _newNodes;
    }

});

module.exports = NewNodeStore;