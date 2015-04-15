/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var Avatar = require('../../shared/elements/avatar');

var moment = require('moment');

var TopicListRow = React.createClass({

    propTypes: {
        topic: React.PropTypes.object
    },

    render: function () {

        var topic = this.props.topic || {};

        return (
            <div {...this.props} className="row">
                <div className="avatar-wrapper">
                    <Avatar url={topic.author.avatar.url} />
                </div>
                <div className="content-wrapper">
                    <h3 className="title"> {topic.title} </h3>
                    <p className="labels">
                        <span className="node">{topic.node.name}</span>
                        <span className="author"><i className="fa fa-user"></i> {topic.author.display_name}</span>
                        <span className="time"><i className="fa fa-clock-o"></i> {moment(topic.created_at).fromNow()}</span>
                        <span className="reply-count"><i className="fa fa-comments"></i> {topic.reply_count}</span>
                    </p>

                </div>

            </div>
        )
    }
});

module.exports = TopicListRow;