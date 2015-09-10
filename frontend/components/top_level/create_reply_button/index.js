/**
 * Created by WildCat on 02/05/15, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var { FloatingActionButton } = require('material-ui');

var CreateReplyDialogActions = require('../../../actions/dialogs/create_reply');

var CreateReplyButton = React.createClass({

    onButtonTouch: function() {
        CreateReplyDialogActions.show();
    },

    render: function() {
        return (
            <FloatingActionButton
                className="create-reply"
                iconClassName="fa fa-reply"
                onTouchTap={this.onButtonTouch}
                secondary={true} />
        )
    }
});

module.exports = CreateReplyButton;