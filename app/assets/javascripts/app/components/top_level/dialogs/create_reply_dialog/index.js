/**
 * Created by WildCat on 02/05/15, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var Navigation = require('react-router').Navigation;

var {
    Dialog,
    FlatButton,
    TextField
    } = require('material-ui');

var CreateReplyDialogStore = require('../../../../stores/dialogs/create_reply');
var CurrentTopicStore = require('../../../../stores/topic/current');

var TopicService = require('../../../../services/topic');

var TopicNetworkingActions = require('../../../../actions/networking/topic');
var GlobalSnackbarActions = require('../../../../actions/global_snackbar');

var CreateReplyDialog = React.createClass({

    mixins: [
        Reflux.listenTo(CreateReplyDialogStore, 'onStoreUpdate'),
        Reflux.listenTo(CurrentTopicStore, 'onTopicStoreUpdate'),
        Navigation
    ],

    getInitialState: function () {
        return {topic: {id: 0}}
    },

    onStoreUpdate: function () {
        this.refs.dialog.show();
    },

    onTopicStoreUpdate: function (data) {
        this.setState({
            topic: data.topic
        });
    },

    onCancelButtonTouch: function () {
        this.refs.dialog.dismiss();
    },

    onSubmitButtonTouch: function () {
        TopicService.createReply(
            this.state.topic.id,
            this.refs.contentField.getValue(),
            null // TODO: implement quoted reply
        ).then((res) => {
                GlobalSnackbarActions.show('回复成功。');
                this.refs.dialog.dismiss();
                this.refs.contentField.clearValue()
                TopicNetworkingActions.getSingle(this.state.topic.id, 1);
            });
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
                label="发表"
                onTouchTap={this.onSubmitButtonTouch}
                primary={true}/>
        ];

        return (
            <Dialog
                className="create-topic"
                ref="dialog"
                title="创建回复"
                actions={customActions}>

                <div>
                    <TextField
                        ref="contentField"
                        floatingLabelText="内容"
                        multiLine={true}/>
                </div>

            </Dialog>
        )
    }
});

module.exports = CreateReplyDialog;