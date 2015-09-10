/**
 * Created by WildCat on 28/04/15, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var { Snackbar } = require('material-ui');

var GlobalSnackbarStore = require('../../../stores/global_snackbar');

var _timeout;

var GlobalSnackbar = React.createClass({

    mixins: [
            Reflux.listenTo(GlobalSnackbarStore, 'onStoreUpdate')
    ],

    getInitialState: function() {
        return {
            message: 'Message is not initialized.'
        };
    },

    onStoreUpdate: function(message) {
        clearTimeout(_timeout);
        this.setState({message: message});
        this.refs.snackbar.show();
        _timeout = setTimeout(() => {
            this.refs.snackbar.dismiss();
        }, 3000)
    },

    handleOKAction: function() {
        this.refs.snackbar.dismiss();
    },

    render: function() {
        return (
            <Snackbar
                ref="snackbar"
                message={this.state.message}
                action="OK"
                onActionTouchTap={this.handleOKAction}
                />
        )
    }
});

module.exports = GlobalSnackbar;