/**
 * Created by WildCat on 28/04/15, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');
var LeftNavMenuAction = require('../actions/left_nav_menu');

var LeftNavMenuStore = Reflux.createStore({

    listenables: LeftNavMenuAction,

    init: function() {
    },

    onToggle: function() {
        this.trigger();
    }

});

module.exports = LeftNavMenuStore;