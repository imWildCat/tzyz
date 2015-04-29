/**
 * Created by WildCat on 29/04/15, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var CreateTopicDialogActions = require('../../../actions/dialogs/create_topic');

var { FloatingActionButton } = require('material-ui');

var CreateTopicButton = React.createClass({

    onButtonTouch: function() {
        CreateTopicDialogActions.show();
    },

    render: function() {
        return (
            <FloatingActionButton
                className="create-topic"
                iconClassName="fa fa-pencil-square-o"
                onTouchTap={this.onButtonTouch}
                secondary={true} />
        )
    }
});

module.exports = CreateTopicButton;