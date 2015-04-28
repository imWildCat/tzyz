/**
 * Created by WildCat on 28/04/15, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var {
    Dialog,
    FlatButton,
    } = require('material-ui');

var LogoutConfirmationStore = require('../../../stores/dialogs/logout_confirmation');

var AccountService = require('../../../services/account');

var SiteNetworkingActions = require('../../../actions/networking/site');
var GlobalSnackbarActions = require('../../../actions/global_snackbar');

var LogoutConfirmationDialog = React.createClass({

    mixins: [
        Reflux.listenTo(LogoutConfirmationStore, 'onStoreUpdate')
    ],

    onStoreUpdate: function () {
        this.refs.dialog.show();
    },

    onCancelButtonTouch: function () {
        this.refs.dialog.dismiss();
    },

    onConfirmButtonTouch: function () {
        this.refs.dialog.dismiss();
        AccountService.logout().then((res) => {
            if(res.body.result == true) {
                GlobalSnackbarActions.show('注销成功。');
                SiteNetworkingActions.getInitialData();
            }
        })
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
                label="确认"
                onTouchTap={this.onConfirmButtonTouch}
                primary={true}/>
        ];

        return (
            <Dialog
                ref="dialog"
                title="用户注销"
                actions={customActions}>

                确认注销当前登录吗？

            </Dialog>
        )
    }
});

module.exports = LogoutConfirmationDialog;