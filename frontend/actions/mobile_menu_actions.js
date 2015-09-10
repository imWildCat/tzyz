/**
 * Created by wildcat, all rights reserved.
 */

"use strict";

var Reflux = require('reflux');

var MainBlurContainerActions = require('./blur_containers/main');

var MobileMenuActions = Reflux.createActions([
    'showMenu',
    'hideMenu'
]);

module.exports = MobileMenuActions;

MobileMenuActions.showMenu.listen(function () {
    MainBlurContainerActions.performBlur();
});

MobileMenuActions.hideMenu.listen(function () {
    MainBlurContainerActions.dismissBlur();
});
