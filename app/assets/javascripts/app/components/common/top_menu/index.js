var React = require('react');

var { Link } = require('react-router');

var NavContainer = require('./nav_container');
var Avatar = require('../../shared/elements/avatar');
var SearchField = require('./search_field');
var MobileButton = require('./mobile_button');
var TabMenu = require('./tab_menu');
var FriendButton = require('./friend_button');
var NotificationButton = require('./notification_button');

var Colors = require('../colors');

var TopMenu = React.createClass({

    render: function () {
        return (
            <NavContainer>
                <i className="logo"></i>

                <div className="brand">
                    <h1><Link to="home"> 滕州一中校友会</Link></h1>
                </div>
                <TabMenu className="hidden-sm" style={{marginLeft: 30}}/>
                <ul className="top-menu-tool-bar float-right" style={{margin:0, padding: 0}}>
                    <MobileButton {...this.props} />
                    <li className="item hidden-md">
                        <FriendButton />
                    </li>
                    <li className="item">
                        <NotificationButton />
                    </li>
                    <li className="item">
                        <Avatar mode="small" url="/assets/no_avatar.png"/>
                    </li>
                </ul>
                <SearchField className="hidden-md"/>
            </NavContainer>
        )
    }
});

module.exports = TopMenu;