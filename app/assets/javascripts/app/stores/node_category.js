/**
 * Created by WildCat on 01/05/15, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');
var NodeCategoryActions = require('../actions/networking/node_category');

var _list = [];

var NodeCategoryStore = Reflux.createStore({

    listenables: NodeCategoryActions,

    init: function() {
    },

    onReceivedList: function(data) {
        _list = data;
        this.trigger(_list);
    },

    getList: function() {
        return _list;
    }

});

module.exports = NodeCategoryStore;