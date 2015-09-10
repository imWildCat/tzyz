/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');
var SiteNetworkingActions = require('../../actions/networking/site');

var _sessionUser = null;

var SessionUserStore = Reflux.createStore({

    listenables: SiteNetworkingActions,

    init: function() {
    },

    onUpdateInitialData: function(data) {
        _sessionUser = data.current_user;
        this.trigger(_sessionUser);
    },

    get: function() {
        return _sessionUser;
    }

});

module.exports = SessionUserStore;