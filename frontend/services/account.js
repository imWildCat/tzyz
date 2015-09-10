/**
 * Created by WildCat on 28/04/15, all rights reserved.
 */

'use strict';

var Client = require('../utilities/client');

module.exports = {

    login: function (accountName, password) {
        return Client.post('accounts/login').query({account: accountName, password: password});
    },
    
    logout: function() {
        return Client.post('accounts/logout');
    },

    register: function (email, nickname, password) {
        return Client.post('accounts/reg').query({email: email, nickname: nickname, password: password});
    }

};