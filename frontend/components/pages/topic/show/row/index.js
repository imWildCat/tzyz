/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');
var { Link } = require('react-router');

var moment = require('moment');

var Avatar = require('../../../../shared/elements/avatar');

var TopicContentRow = React.createClass({

    propTypes: {
        data: React.PropTypes.object,
        isTopic: React.PropTypes.bool
    },

    render: function () {

        var data = this.props.data;
        var isTopic = this.props.isTopic;
        var className = 'row';
        if (isTopic) {
            className += ' topic'
        }

        // right meta
        var rightMeta;
        var nodeName;
        if (isTopic) {
            rightMeta =
                <div className="right">
                    <span className="view-count"><i className="fa fa-eye"></i>{data.click_count}</span>
                    <span className="favorite-count"><i className="fa fa-star"></i>{data.favorite_count}</span>
                    <span className="appreciation-count"><i className="fa fa-heart"></i>{data.appreciation_count}</span>
                </div>
            nodeName =
                <span className="node-name">
                    <Link to="nodeShow" params={{slug: data.node.slug}}>{data.node.name}</Link>
                </span>
        } else {
            rightMeta =
                <div className="right">
                    <span className="appreciation-count"><i className="fa fa-heart"></i>{data.appreciation_count}</span>
                    <span className="reply-action"><i className="fa fa-reply"></i>#{data.position}</span>
                </div>
            nodeName = <span></span>
        }

        return (
            <div className={className}>
                <div className="avatar-wrapper">
                    <Avatar url={data.author.avatar_url}/>
                </div>
                <div className="content-wrapper">
                    <div className="meta">
                        <div className="left">
                            <span className="author-name">
                                <Link to="userShow" params={{id: data.author.id}}>{data.author.display_name}</Link>
                            </span>
                            <span className="device"><i className="fa fa-mobile"></i></span>
                            <span className="time">{moment(data.created_at).fromNow()}</span>
                            {nodeName}
                        </div>
                        {rightMeta}
                    </div>
                    <div className="content" dangerouslySetInnerHTML={{__html: data.content}}>
                    </div>
                </div>
            </div>
        )
    }
});

module.exports = TopicContentRow;