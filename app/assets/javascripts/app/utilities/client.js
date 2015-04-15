var Networking = require('./networking');

const BASE_URL = '//api/v1/';

var Client = {
    get: function (uri) {
        return Networking.get(BASE_URL + uri);
    },
    post: function(uri) {
        return Networking.post(BASE_URL + uri);
    }
};
