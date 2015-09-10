/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var FriendButton = React.createClass({
    render: function() {
        return (
            <i className="fa fa-users top-menu-icon"></i>
        )
    }
});


module.exports = FriendButton;