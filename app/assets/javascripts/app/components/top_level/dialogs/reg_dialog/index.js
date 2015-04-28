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

var RegDialogStore = require('../../../../stores/reg_dialog');

var AccountService = require('../../../../services/account');

var GlobalSnackbarActions = require('../../../../actions/global_snackbar');
var SiteNetworkingActions = require('../../../../actions/networking/site');


var RegDialog = React.createClass({

    mixins: [
        Reflux.listenTo(RegDialogStore, 'onStoreUpdate')
    ],

    onStoreUpdate: function () {
        this.refs.dialog.show();
    },

    onRegButtonTouch: function () {
        var email = this.refs.accountField.getValue();
        var nickname = this.refs.nicknameField.getValue();
        var password = this.refs.passwordField.getValue();
        AccountService.register(email, nickname, password).then((res) => {
           if (res.body.current_user) {
               GlobalSnackbarActions.show('注册成功！');
               SiteNetworkingActions.getInitialData();
               this.refs.dialog.dismiss();
           }  else {
               GlobalSnackbarActions.show('注册失败，未知错误。请联系管理员。');
           }
        });
    },

    onCancelButtonTouch: function () {
        this.refs.dialog.dismiss();
    },

    render: function () {

        var customActions = [
            <FlatButton
                key="cancel"
                label="取消"
                onTouchTap={this.onCancelButtonTouch}
                secondary={true}/>,
            <FlatButton
                key="submit"
                label="注册"
                onTouchTap={this.onRegButtonTouch}
                primary={true}/>
        ];

        return (
            <Dialog
                ref="dialog"
                title="用户注册"
                actions={customActions}>

                <div>
                    <TextField ref="accountField" hintText="邮箱"/>
                </div>
                <div>
                    <TextField ref="nicknameField" hintText="昵称"/>
                </div>
                <div>
                    <TextField ref="passwordField" hintText="密码"/>
                </div>

            </Dialog>
        )
    }
});

module.exports = RegDialog;