/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');
var { Navigation } = require('react-router');

var Badge = require('./badge');

var NotificationButton = React.createClass({

    mixins: [
        //Reflux.listenTo(//, 'onStoreUpdate'),
        Navigation
    ],

    onButtonTouch: function() {
        this.context.router.transitionTo('notifications');
    },

    render: function() {
        return (
            <a onTouchTap={this.onButtonTouch} style={{display: 'inline-block'}}>
                <i className="fa fa-bell top-menu-icon"></i>
                <Badge num="1" />
            </a>
        )
    }
});


module.exports = NotificationButton;