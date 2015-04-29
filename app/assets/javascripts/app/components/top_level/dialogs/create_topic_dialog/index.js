/**
 * Created by WildCat on 29/04/15, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var CreateTopicDialogStore = require('../../../../stores/dialogs/create_topic');

var {
    Dialog,
    FlatButton,
    TextField
    } = require('material-ui');

var GlobalSnackbarActions = require('../../../../actions/global_snackbar');

var CreateTopicDialog = React.createClass({

    mixins: [
            Reflux.listenTo(CreateTopicDialogStore, 'onStoreUpdate')
    ],

    onStoreUpdate: function(nodeData) {
        this.refs.dialog.show();
    },

    onCancelButtonTouch: function () {
        this.refs.dialog.dismiss();
        GlobalSnackbarActions.show('取消');
    },

    onSubmitButtonTouch: function() {
        GlobalSnackbarActions.show('发布');
    },

    render: function() {

        var customActions = [
            <FlatButton
                key="cancel"
                label="取消"
                onTouchTap={this.onCancelButtonTouch}
                secondary={true}/>,
            <FlatButton
                key="submit"
                label="发表"
                onTouchTap={this.onSubmitButtonTouch}
                primary={true}/>
        ];
        return (
            <Dialog
                ref="dialog"
                title="创建话题"
                actions={customActions}>

                <div>
                    <TextField
                        floatingLabelText="标题" />
                </div>

                <div>
                    <TextField
                        floatingLabelText="内容"
                        multiLine={true} />
                </div>


            </Dialog>
        )
    }
});

module.exports = CreateTopicDialog;