/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');
var NodeNetworkingActions = require('../../actions/networking/node');

var _node = {};

var CurrentNodeStore = Reflux.createStore({

    listenables: NodeNetworkingActions,

    init: function () {
    },

    onReceivedSingle: function (data) {
        _node = data;
        this.trigger(_node);
    }

});

module.exports = CurrentNodeStore;