/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');

var MainBlurContainerActions = require('./blur_containers/main');

var LoginDialogActions = Reflux.createActions([
    'show',
    'dismiss'
]);

module.exports = LoginDialogActions;
console.log(LoginDialogActions);

LoginDialogActions.show.listen(() => {
    MainBlurContainerActions.performBlur();
});

LoginDialogActions.dismiss.listen(() => {
    MainBlurContainerActions.dismissBlur();
}); 