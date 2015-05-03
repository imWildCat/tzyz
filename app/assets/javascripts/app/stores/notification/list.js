/**
 * Created by WildCat on 02/05/15, all rights reserved.
 */

'use strict';


var Reflux = require('reflux');
var NotificationNetworkingActions = require('../../actions/networking/notification');

var _list = [];

var NotificationListStore = Reflux.createStore({

    listenables: NotificationNetworkingActions,

    init: function() {
    },

    onReceivedList: function(data) {
        _list = data;
        this.trigger(_list);
    }

});

module.exports = NotificationListStore;