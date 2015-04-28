/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');
var {
        Dialog,
        FlatButton
    } = require('material-ui');

var LoginDialogStore = require('../../../stores/login_dialog');

var DefaultMask = require('../../shared/default_mask');


var LoginDialog = React.createClass({

    mixins: [
        Reflux.listenTo(LoginDialogStore, 'onStoreUpdate')
    ],

    onStoreUpdate: function (shouldShow) {
        this.setState({shouldShow: shouldShow})
    },

    getInitialState: function () {
        return {shouldShow: LoginDialogStore.get()}
    },

    render: function () {

        var style;
        if (this.state.shouldShow) {
            style = {};
        } else {
            style = {display: 'none'};
        }

        var customActions = [
            <FlatButton
                label="Cancel"
                secondary={true}/>,
            <FlatButton
                label="Submit"
                primary={true}/>
        ];

        return (
            <Dialog
                title="Dialog With Custom Actions"
                actions={customActions}
                modal={this.state.modal}>
                The actions in this window were passed in as an array of react objects.
            </Dialog>
        )
    }
});

module.exports = LoginDialog;