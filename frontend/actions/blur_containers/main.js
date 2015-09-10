/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');

var MainBlurContainerAction = Reflux.createActions([
    'performBlur',
    'dismissBlur',
    //'containerTouched'
]);

module.exports = MainBlurContainerAction;