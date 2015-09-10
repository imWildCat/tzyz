/**
 * Created by WildCat on 02/05/15, all rights reserved.
 */

'use strict';


var Reflux = require('reflux');
var CreateReplyDialogActions = require('../../actions/dialogs/create_reply');

var CreateReplyDialogStore = Reflux.createStore({

    listenables: CreateReplyDialogActions,

    init: function () {
    },

    onShow: function () {
        this.trigger();
    }

});

module.exports = CreateReplyDialogStore;