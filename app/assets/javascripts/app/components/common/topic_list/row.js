/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var { Link } = require('react-router');

var Avatar = require('../../shared/elements/avatar');

var moment = require('moment');

var TopicListRow = React.createClass({

    propTypes: {
        topic: React.PropTypes.object,
        isNodePage: React.PropTypes.bool
    },

    render: function () {

        var topic = this.props.topic || {};

        var shouldHideReplyCount = parseInt(topic.reply_count) === 0;
        var replyCountStyle = {};
        if (shouldHideReplyCount) {
            replyCountStyle['display'] = 'none';
        }

        var className = "row";
        var nodeSpan;
        if (this.props.isNodePage) {
            className += " in-node-page";
            nodeSpan = <i></i>
        } else {
            nodeSpan =
                <span className="node">
                    <Link to="nodeShow" params={{slug: topic.node.slug}}> {topic.node.name} </Link>
                </span>
        }

        return (
            <div {...this.props} className={className}>
                <div className="avatar-wrapper">
                    <Avatar url={topic.author.avatar_url}/>
                </div>
                <div className="content-wrapper">
                    <h3 className="title">
                        <Link to="topicShow" params={{id: topic.id}}> {topic.title} </Link>
                    </h3>

                    <p className="labels">
                        {nodeSpan}
                        <span className="author"><i className="fa fa-user"></i> {topic.author.display_name}</span>
                        <span className="time"><i
                            className="fa fa-clock-o"></i> {moment(topic.created_at).fromNow()}</span>
                        <span className="reply-count" style={replyCountStyle}><i
                            className="fa fa-comments"></i> {topic.reply_count}</span>
                    </p>

                </div>

            </div>
        )
    }
});

module.exports = TopicListRow;