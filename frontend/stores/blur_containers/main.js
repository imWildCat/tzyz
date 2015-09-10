/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');
var BlurContainerActions = require('../../actions/blur_containers/main');

var _blurred = false;

var MainBlurContainerStore = Reflux.createStore({

    listenables: BlurContainerActions,

    init: function () {
    },

    onPerformBlur: function() {
        _blurred = true;
        this.trigger(_blurred);
    },

    onDismissBlur: function() {
        _blurred = false;
        this.trigger(_blurred);
    },

    //onContainerTouched: function() {
    //    if(_blurred) {
    //        _blurred = !_blurred;
    //    }
    //    this.trigger(_blurred);
    //}


});

module.exports = MainBlurContainerStore;