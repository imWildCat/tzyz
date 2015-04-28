/**
 * Created by WildCat on 28/04/15, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');
var RegDialogActions = require('../actions/reg_dialog');

var RegDialogStore  = Reflux.createStore({

    listenables: RegDialogActions,

    init: function() {
    },

    onShow: function() {
        this.trigger();
    }

});

module.exports = RegDialogStore;