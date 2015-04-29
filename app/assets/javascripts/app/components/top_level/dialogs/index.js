/**
 * Created by WildCat on 28/04/15, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var RegDialog = require('./reg_dialog');
var LoginDialog = require('./login_dialog');
var LogoutConfirmationDialog = require('./logout_confirmation');
var CreateTopicDialog = require('./create_topic_dialog');

var Dialogs = React.createClass({

    render: function() {
        return (
            <div>
                <RegDialog />
                <LoginDialog />
                <LogoutConfirmationDialog />
                <CreateTopicDialog />
            </div>
        )
    }
});

module.exports = Dialogs;