/**
 * Created by WildCat on 01/05/15, all rights reserved.
 */

'use strict';


var Reflux = require('reflux');

var NodeCategoryService = require('../../services/node_category');

var NodeCategoryNetworkingActions = Reflux.createActions([
    'getList',
    'receivedList'
]);

module.exports = NodeCategoryNetworkingActions;

NodeCategoryNetworkingActions.getList.listen(() => {
    NodeCategoryService.getList().then((res) => {
        NodeCategoryNetworkingActions.receivedList(res.body);
    });
});