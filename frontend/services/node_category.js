/**
 * Created by WildCat on 01/05/15, all rights reserved.
 */

'use strict';

var Client = require('../utilities/client');

module.exports = {

    getList: function() {
        return Client.get('node_categories/list');
    }

};
