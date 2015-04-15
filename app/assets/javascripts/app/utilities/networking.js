'use strict';

var request = require('superagent');

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
            if (response.ok && response.status === 200) {
                if (self.thenCb != null) {
                    self.thenCb(response);
                }
            } else {
                if (self.errorCb != null) {
                    self.errorCb(error, response);
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