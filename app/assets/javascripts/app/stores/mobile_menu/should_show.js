/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');
var MobileMenuActions = require('../../actions/mobile_menu_actions');

var _shouldShow = false;

var ShouldShow = Reflux.createStore({

    listenables: MobileMenuActions,

    init: function() {
    },

    onToggle: function() {
        _shouldShow = !_shouldShow;
        this.trigger(_shouldShow);
    }

});

module.exports = ShouldShow;