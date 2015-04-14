/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var MobileMenuActions = require('../../../actions/mobile_menu_actions');
var ShouldShowStore = require('../../../stores/mobile_menu/should_show');

var DefaultMask = require('../../shared/default_mask');
var CloseButton = require('../../shared/elements/close_button');

var NavContainer = require('../top_menu/nav_container');
var TabMenu = require('../top_menu/tab_menu');
var FriendButton = require('../top_menu/friend_button');
var NotificationButton = require('../top_menu/notification_button');
var Avatar = require('../top_menu/avatar');
var SearchField = require('../top_menu/search_field');

var MobileMenu = React.createClass({

    mixins: [Reflux.ListenerMixin],

    getInitialState: function () {
        return {
            shouldShow: false
        }
    },

    componentDidMount: function () {
        this.listenTo(ShouldShowStore, this.onShouldShowChange);
    },

    onShouldShowChange: function (shouldShow) {
        this.setState({shouldShow: shouldShow});
    },

    onCloseButtonClick: function () {
        MobileMenuActions.hideMenu();
    },

    render: function () {
        var style;
        if (this.state.shouldShow) {
            style = {};
        } else {
            style = {
                display: 'none'
            };
        }
        return (
            <DefaultMask style={style}>
                <NavContainer isMobile={true}>
                    <CloseButton onTouchTap={this.onCloseButtonClick} style={{
                        display: 'block',
                        position: 'fixed',
                        top: 15,
                        right: 20
                    }} />
                    <TabMenu className="visible-sm" />
                    <div style={{clear: 'both', paddingLeft: 10, paddingRight: 10}}>
                        <SearchField style={{float: 'left'}} />
                        <ul className="top-menu-tool-bar">
                            <li className="item">
                                <FriendButton />
                            </li>
                            <li className="item hidden-sm">
                                <NotificationButton />
                            </li>
                            <li className="item hidden-sm">
                                <Avatar url="/assets/no_avatar.png" />
                            </li>
                        </ul>
                    </div>
                </NavContainer>
            </DefaultMask>
        )
    }
});


module.exports = MobileMenu;