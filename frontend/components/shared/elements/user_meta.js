/**
 * Created by WildCat on 04/05/15, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var SessionUserStore = require('../../../stores/site/session_user');
var Avatar = require('../../shared/elements/avatar');

var UserMeta = React.createClass({

    propTypes: {
        title: React.PropTypes.string
    },

    mixins: [
        Reflux.listenTo(SessionUserStore, 'onSessionUserStoreUpdate')
    ],

    getInitialState: function() {
        return {
            user: SessionUserStore.get()
        }
    },

    onSessionUserStoreUpdate: function (user) {
        this.setState({ user: user });
    },

    render: function() {
        var avatarURL = this.state.user? this.state.user.avatar_url : null;

        return (
            <div className="user-meta">
                <Avatar mode="big" url={ avatarURL } />

                <p>{this.props.title}</p>
                <div>
                    { this.props.children }
                </div>
            </div>
        )
    }
});

module.exports = UserMeta;