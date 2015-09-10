/**
 * Created by WildCat on 29/04/15, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');
var Navigation = require('react-router').Navigation;

var TopicService = require('../../../../services/topic');

//var Chosen = require('../../../shared/elements/chosen');
var NodeChosen = require('./node_chosen');

var CreateTopicDialogStore = require('../../../../stores/dialogs/create_topic');

var {
    Dialog,
    FlatButton,
    TextField
    } = require('material-ui');

var GlobalSnackbarActions = require('../../../../actions/global_snackbar');

var CreateTopicDialog = React.createClass({

    mixins: [
        Reflux.listenTo(CreateTopicDialogStore, 'onStoreUpdate'),
        Navigation
    ],

    onNodeChosenChange: function (id) {
        this.props.nodeID = id;
    },

    onStoreUpdate: function (nodeData) {
        this.refs.dialog.show();
    },

    onCancelButtonTouch: function () {
        this.refs.dialog.dismiss();
    },

    onSubmitButtonTouch: function () {
        TopicService.createTopic(this.props.nodeID,
            this.refs.titleField.getValue(),
            this.refs.contentField.getValue()).then((res) => {
                this.context.router.transitionTo('topicShow', {id: res.body.topic_id});
                this.refs.dialog.dismiss();
                GlobalSnackbarActions.show('主题发布成功。');
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
                title="创建话题"
                actions={customActions}>

                <NodeChosen onChange={this.onNodeChosenChange}/>

                <div>
                    <TextField
                        ref="titleField"
                        floatingLabelText="标题"/>
                </div>
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

module.exports = CreateTopicDialog;