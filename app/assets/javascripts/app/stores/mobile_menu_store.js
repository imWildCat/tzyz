/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');
var MobileMenuActions = require('../actions/mobile_menu_actions');

var shouldShow = false;

var MobileMenuStore = Reflux.createStore({

    listenables: MobileMenuActions,

    init: function() {
    },

    onToggle: function() {

    }


});

module.exports = MobileMenuStore;