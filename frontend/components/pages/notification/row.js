/**
 * Created by WildCat on 03/05/15, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');
var moment = require('moment');
var { Link } = require('react-router');

var Avatar = require('../../shared/elements/avatar');

var NotificationRow = React.createClass({

    propTypes: {
        notification: React.PropTypes.object
    },

    generateHeadlineElement: function (notification) {

        var message1 = '';
        var message2 = '';

        switch (notification.n_type) {
            case 'replied':
                message1 = '回复了你的话题';
                break;
            case 'mentioned_in_reply':
                message1 = '在回复话题';
                message2 = '时提到了你';
                break;
            case 'mentioned_in_topic':
                message1 = '在话题';
                message2 = '中提到了你';
                break;
            case 'reply_deleted':
                message1 = '你在话题';
                message2 = '中的回复已被管理团队删除';
                break;
            case 'topic_deleted':
                message1 = '你的话题';
                message2 = '已被管理团队删除';
                break;
            case 'topic_locked':
                message1 = '你的话题';
                message2 = '已被管理团队锁定';
                break;
            case 'user_welcome':
                message1 = '感谢您注册 滕州一中校友会';
                break;
            case 'topic_favorited':
                message1 = '收藏了你的话题';
                break;
            case 'topic_appreciated':
                message1 = '感谢了你的话题';
                break;
            case 'reply_appreciated':
                message1 = '感谢了你在话题';
                message2 = '中的回复';
                break;
            case 'reply_quoted':
                message1 = '在话题';
                message2 = '中回复了你的发言';
                break;
        }

        var relatedUserElement = <b></b> ;
        if(notification.related_user) {
            relatedUserElement =
                <Link to="userShow" params={{id: notification.related_user.id}}> {notification.related_user.display_name} </Link>
        }

        var relatedTopicTitle = <b></b> ;
        if(notification.related_topic) {
            relatedTopicTitle = <Link to="topicShow" params={{id: notification.related_topic.id}}> {notification.related_topic.title} </Link>
        }

        return (
            <span>
                {relatedUserElement}
                {message1}
                {relatedTopicTitle}
                {message2}
            </span>
        )
    },

    render: function () {
        var n = this.props.notification;
        var relatedUser = n.related_user;
        var relatedAvatarURI = relatedUser ? relatedUser.avatar_url : '/assets/no_avatar.png';


        var headlineElement = this.generateHeadlineElement(n);

        return (
            <div className="notification-row">
                <div className="avatar-wrapper">
                    <Avatar url={relatedAvatarURI} mode="medium"/>
                </div>
                <div className="content-wrapper">
                    <span className="time float-right">{moment(n.created_at).fromNow()}</span>

                    <p className="meta-info">
                        { headlineElement }
                    </p>
                    <p className="content">
                        { n.related_content }
                    </p>
                </div>
            </div>
        )
    }
});

module.exports = NotificationRow;