/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var MobileButton = require('./mobile_button');
var FriendButton = require('./friend_button');
var NotificationButton = require('./notification_button');
var Avatar = require('../../shared/elements/avatar');

var LoginDialogActions = require('../../../actions/login_dialog');
var RegDialogActions = require('../../../actions/reg_dialog');
var LeftNavMenuActions = require('../../../actions/left_nav_menu');
var SessionUserStore = require('../../../stores/site/session_user');

var ToolBar = React.createClass({

    propTypes: {
        isMobile: React.PropTypes.bool
    },

    mixins: [
        Reflux.listenTo(SessionUserStore, 'onStoreUpdate')
    ],

    getInitialState: function () {
        return {
            sessionUser: SessionUserStore.get()
        };
    },

    onStoreUpdate: function (sessionUser) {
        this.setState({
            sessionUser: sessionUser
        });
    },

    onLoginButtonTouch: function () {
        LoginDialogActions.show();
    },

    onRegButtonTouch: function () {
        RegDialogActions.show();
    },

    onAvatarTouch: function () {
        LeftNavMenuActions.toggle();
    },

    render: function () {
        var className,
            friendButton, friendButtonClassName = 'item',
            notificationButton, notificationButtonClassName = 'item',
            sessionUserButton, sessionUserButtonClassName = 'item',
            regButton, loginButton, mobileButton;

        if(!this.props.isMobile) {
            mobileButton = <MobileButton {...this.props} />;
            className = 'top-menu-tool-bar float-right';
            friendButtonClassName += ' hidden-md';
        } else {
            className = 'top-menu-tool-bar';
            notificationButtonClassName += ' hidden-sm';
            sessionUserButtonClassName += ' hidden-sm';
        }

        if (this.state.sessionUser) {
            friendButton =
                <li className={friendButtonClassName}>
                    <FriendButton />
                </li>;
            notificationButton =
                <li className={notificationButtonClassName}>
                    <NotificationButton />
                </li>;
            sessionUserButton =
                <li className={sessionUserButtonClassName}>
                    <Avatar onTouchTap={this.onAvatarTouch} mode="small" url={this.state.sessionUser.avatar_url}/>
                </li>;
        } else {
            regButton =
                <li className="item text">
                    <a onTouchTap={this.onRegButtonTouch}>注册</a>
                </li>;
            loginButton =
                <li className="item text">
                    <a onTouchTap={this.onLoginButtonTouch}>登录</a>
                </li>;
        }


        return (
            <ul className={className} style={{margin:0, padding: 0}}>
                {mobileButton}
                {friendButton}
                {notificationButton}
                {sessionUserButton}
                {regButton}
                {loginButton}
            </ul>
        )
    }
});

module.exports = ToolBar;