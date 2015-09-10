/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var TopicNetworkingActions = require('../../../../actions/networking/topic');
var CurrentTopicStore = require('../../../../stores/topic/current');

var Page = require('../../../shared/containers/page');
var Card = require('../../../shared/containers/card');

var CreateReplyButton = require('../../../top_level/create_reply_button');

var TopicContentRow = require('./row');

var TopicShowPage = React.createClass({

    contextTypes: {
        router: React.PropTypes.func
    },

    mixins: [
        Reflux.listenTo(CurrentTopicStore, 'onStoreUpdate')
    ],

    componentWillMount: function () {
        this.requestData();
    },

    componentWillReceiveProps: function (nextProps) {
        this.requestData();
    },

    requestData: function () {
        var { id } = this.context.router.getCurrentParams();
        TopicNetworkingActions.getSingle(id, 1);
    },

    getInitialState: function () {
        return {topic: {}, replies: []}
    },

    onStoreUpdate: function (data) {
        this.setState(data);
    },

    render: function () {

        var topic = this.state.topic;

        var topicContent = <div></div>;
        if (topic.title) {
            topicContent = <TopicContentRow data={topic} isTopic={true} />
        }

        var replyList = this.state.replies.map((r) => {
            return (
                <div className="reply-row-wrapper" key={'r_'+r.id}>
                    <TopicContentRow data={r} isTopic={false} />
                </div>
            )
        });

        return (
            <Page id="topic-show-page">
                <Card autoPadding={true}>
                    <h1 className="title">{topic.title}</h1>
                    {topicContent}
                </Card>
                <Card style={{marginTop: 20}}>
                    {replyList}
                </Card>
                <CreateReplyButton />
            </Page>
        )
    }
});

module.exports = TopicShowPage;