/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var Badge = require('./badge');

var NotificationButton = React.createClass({
    render: function() {
        return (
            <span style={{display: 'inline-block'}}>
                <i className="fa fa-bell top-menu-icon"></i>
                <Badge num="1" />
            </span>
        )
    }
});


module.exports = NotificationButton;