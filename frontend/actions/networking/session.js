/**
 * Created by WildCat on 28/04/15, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');

var SessionService = require('../../services/session');

var SessionNetworkingActions = Reflux.createActions([
    'login'
]);

module.exports = SessionNetworkingActions;

SessionNetworkingActions.login.liten((accountName, password) => {

});