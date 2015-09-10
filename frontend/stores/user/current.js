/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');
var UserNetworkingActions = require('../../actions/networking/user');

var _user = {};

var CurrentUserStore = Reflux.createStore({

    listenables: UserNetworkingActions,

    init: function () {
    },

    onReceivedSingle: function (data) {
        _user = data;
        this.trigger(_user);
    },

    get: function() {
        return _user;
    }

});

module.exports = CurrentUserStore;