/**
 * Created by WildCat on 28/04/15, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');
var GlobalSnackbarActions = require('../actions/global_snackbar');

var GlobalSnackbarStore = Reflux.createStore({

    listenables: GlobalSnackbarActions,

    init: function() {
    },

    onShow: function(message) {
        this.trigger(message);
    }

});

module.exports = GlobalSnackbarStore;