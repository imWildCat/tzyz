/**
 * Created by WildCat on 02/05/15, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');

var NotificationService = require('../../services/notification');

var NotificationNetworkingActions = Reflux.createActions([
    'getList',
    'receivedList'
]);

module.exports = NotificationNetworkingActions;

NotificationNetworkingActions.getList.listen((page) => {
    NotificationService.getList(page).then((res) => {
        NotificationNetworkingActions.receivedList(res.body);
    })
});