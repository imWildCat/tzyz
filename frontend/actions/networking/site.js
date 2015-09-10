/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var Reflux = require('reflux');

var SiteService = require('../../services/site');

var SiteNetworkingActions = Reflux.createActions([
    'getInitialData',
    'updateInitialData'
]);

module.exports = SiteNetworkingActions;

SiteNetworkingActions.getInitialData.listen(() => {
    SiteService.getInitialData().then((res) => {
        SiteNetworkingActions.updateInitialData(res.body);
    });
});
