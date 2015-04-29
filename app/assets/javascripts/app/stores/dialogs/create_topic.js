/**
 * Created by WildCat on 29/04/15, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');
var CreateTopicDialogActions = require('../../actions/dialogs/create_topic');

var CreateTopicDialogStore = Reflux.createStore({

    listenables: CreateTopicDialogActions,

    init: function() {
    },

    onShow: function(nodeData) {
        this.trigger(nodeData);
    }

});

module.exports = CreateTopicDialogStore;