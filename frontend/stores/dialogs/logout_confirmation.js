/**
 * Created by WildCat on 28/04/15, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');
var LogoutConfirmationActions = require('../../actions/dialogs/logout_confirmation');

var LogoutConfirmationStore  = Reflux.createStore({

    listenables: LogoutConfirmationActions,

    init: function() {
    },

    onShow: function() {
        this.trigger();
    }

});

module.exports = LogoutConfirmationStore;