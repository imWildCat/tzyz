/**
 * Created by WildCat on 04/05/15, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var SessionUserStore = require('../../../stores/site/session_user');


var AccountProfilePage = React.createClass({

    contextTypes: {
        router: React.PropTypes.func
    },

    getInitialState: function () {
        return {
            user: SessionUserStore.get()
        }
    },

    mixins: [
        Reflux.listenTo(SessionUserStore, 'onSessionUserStoreUpdate')
    ],

    onSessionUserStoreUpdate: function(user) {
        this.setState({ user: user });
    },

    render: function() {
        return (
            <div>
            </div>
        )
    }
});

module.exports = AccountProfilePage;