/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');

var NodeService = require('../../services/node');

var NodeNetworkingActions = Reflux.createActions([
    'getSingle',
    'receivedSingle'
]);

module.exports = NodeNetworkingActions;

NodeNetworkingActions.getSingle.listen((slug, page) => {
    NodeService.getSingle(slug, page).then((res) => {
        NodeNetworkingActions.receivedSingle(res.body);
    }).error((err, res) => {
        alert('网络错误');
        console.log(err);
    })
});