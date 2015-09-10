/**
 * Created by WildCat on 04/05/15, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');
var UnreadNotificationActions = require('../../actions/unread_notification');

var _count = 0;

var UnreadNotificationStore = Reflux.createStore({

    listenables: UnreadNotificationActions,

    init: function() {
    },

    onCountUpdate: function(newCount) {
        _count = parseInt(newCount);
        this.trigger(_count);
    },

    getCount: function() {
        return _count;
    }

});

module.exports = UnreadNotificationStore;