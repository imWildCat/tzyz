/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');
var LoginDialogActions = require('../actions/login_dialog');


var LoginDialogStore  = Reflux.createStore({

    listenables: LoginDialogActions,

    init: function() {
    },

    onShow: function() {
        this.trigger();
    }

});

module.exports = LoginDialogStore;