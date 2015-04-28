/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');
var LoginDialogActions = require('../actions/login_dialog');

var _shouldShow = false;

var LoginDialogStore  = Reflux.createStore({

    listenables: LoginDialogActions,

    init: function() {
    },

    onShow: function() {
        _shouldShow = true;
        this.trigger(_shouldShow);
    },

    onDismiss: function() {
        _shouldShow = false;
        this.trigger(_shouldShow);
    },

    get: function() {
        return _shouldShow;
    }

});

module.exports = LoginDialogStore;