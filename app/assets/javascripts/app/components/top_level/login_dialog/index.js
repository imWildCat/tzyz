/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');
var {
    Dialog,
    FlatButton,
    TextField
    } = require('material-ui');

var LoginDialogStore = require('../../../stores/login_dialog');

var SessionService = require('../../../services/session');

var GlobalSnackbarActions = require('../../../actions/global_snackbar');
var SiteNetworkingActions = require('../../../actions/networking/site');

var DefaultMask = require('../../shared/default_mask');


var LoginDialog = React.createClass({

    mixins: [
        Reflux.listenTo(LoginDialogStore, 'onStoreUpdate')
    ],

    onStoreUpdate: function (shouldShow) {
        //this.setState({shouldShow: shouldShow})
        this.refs.dialog.show();
    },

    //componentDidUpdate: function(prevProps, prevState) {
    //    if (this.state.shouldShow) {
    //        this.refs.dialog.show();
    //    } else {
    //        this.refs.dialog.dismiss();
    //    }
    //},

    onLoginButtonTouch: function () {
        SessionService.login(this.refs.accountField.getValue(), this.refs.passwordField.getValue()).then((res, error) => {

            GlobalSnackbarActions.show('登录成功！');
            SiteNetworkingActions.getInitialData();
            this.refs.dialog.dismiss();
        }).error((err, res) => {
            // TODO: handle error
            GlobalSnackbarActions.show(res.body.error_message);
        });
    },

    onCancelButtonTouch: function () {

    },

    render: function () {

        var customActions = [
            <FlatButton
                key="cancel"
                label="取消"
                secondary={true}/>,
            <FlatButton
                key="submit"
                label="登录"
                onTouchTap={this.onLoginButtonTouch}
                primary={true}/>
        ];

        return (
            <Dialog
                ref="dialog"
                title="用户登录"
                actions={customActions}>

                <div>
                    <TextField ref="accountField" hintText="邮箱"/>
                </div>
                <div>
                    <TextField ref="passwordField" hintText="密码"/>
                </div>

            </Dialog>
        )
    }
});

module.exports = LoginDialog;