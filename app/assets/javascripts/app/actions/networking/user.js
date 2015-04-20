/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');
var UserService = require('../../services/user');

var UserNetworkingActions = Reflux.createActions([
    'getSingle',
    'receivedSingle'
]);

module.exports = UserNetworkingActions;

UserNetworkingActions.getSingle.listen((id) => {
    UserService.getSingle(id).then((res) => {
        UserNetworkingActions.receivedSingle(res.body);
    }).error((err, res) => {
        // TODO: handle error
        alert('网络错误');
        console.log(err);
    })
});