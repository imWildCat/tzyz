/**
 * Created by WildCat on 02/05/15, all rights reserved.
 */

'use strict';

var Client = require('../utilities/client');

module.exports = {

    getList: function(page) {
        page = page || 1;
        return Client.get('notifications/list').query({ page: page });
    }

};
