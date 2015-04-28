/**
 * Created by WildCat on 28/04/15, all rights reserved.
 */

'use strict';

var Client = require('../utilities/client');

module.exports = {

    login: function(accountName, password) {
        return Client.post('accounts/login').query({account: accountName, password: password});
    }

};