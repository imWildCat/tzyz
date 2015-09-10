'use strict';

var request = require('superagent');

var GlobalSnackbarActions = require('../actions/global_snackbar');
var UnreadNotificationActions = require('../actions/unread_notification');

var Delegate = function () {
    this.thenCb = null;
    this.errorCb = null;
    this.url = null;
    this.method = 'get';
    this.queries = {};
    this.sends = {};
    this.headers = {};
    this.hasStarted = false;
};

Delegate.prototype = {
    then: function (thenCb) {
        this.thenCb = thenCb;
        this.start();
        return this;
    },
    error: function (errorCb) {
        this.errorCb = errorCb;
        this.start();
        return this;
    },
    get: function (url) {
        this.url = url;
        this.method = 'get';
        return this;
    },
    post: function (url) {
        this.url = url;
        this.method = 'post';
        this.headers['Content-Type'] = 'application/x-www-form-urlencoded';
        return this;
    },
    set: function(key, value) {
        this.headers[key] = value;
        return this;
    },
    start: function () {
        if (this.hasStarted == true) return;

        this.hasStarted = true;

        var next;
        if (this.method === 'get') {
            next = request.get(this.url);
        } else {
            next = request.post(this.url);
        }

        var self = this;

        next.query(this.queries).send(this.sends).set(this.headers).end(function (error, response) {
            if(typeof response === 'undefined') {
                GlobalSnackbarActions.show('网络错误，加载失败。');
                return;
            }

            UnreadNotificationActions.countUpdate(response.headers.n_count);

            if (response.body.error_code == null && response.ok) {
                if (self.thenCb != null) {
                    self.thenCb(response);
                }
            } else {
                if (self.errorCb != null) {
                    self.errorCb(error, response);
                }
                if (response.body.error_message != null) {
                    GlobalSnackbarActions.show(response.body.error_message);
                } else {
                    GlobalSnackbarActions.show('网络错误，加载失败。');
                }
            }
        });
    },
    query: function (queries) {
        this.queries = queries;
        return this;
    },
    send: function (sends) {
        this.sends = sends;
        return this;
    }
};

var Client = {
    get: function (url) {
        return new Delegate().get(url);
    },
    post: function (url) {
        return new Delegate().post(url);
    }
};

module.exports = Client;