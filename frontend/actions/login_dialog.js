/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');

var MainBlurContainerActions = require('./blur_containers/main');

var LoginDialogActions = Reflux.createActions([
    'show'
]);

module.exports = LoginDialogActions;