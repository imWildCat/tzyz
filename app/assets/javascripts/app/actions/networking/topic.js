/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');

var TopicService = require('../../services/topic');

var TopicNetworkingActions = Reflux.createActions([
    'getSingle',
    'receivedSingle'
]);

module.exports = TopicNetworkingActions;

TopicNetworkingActions.getSingle.listen((id, page) => {
    TopicService.getSingle(id, page).then((res) => {
        TopicNetworkingActions.receivedSingle(res.body);
    }).error((err, res) => {
        alert('网络错误');
        console.log(err);
    })
});