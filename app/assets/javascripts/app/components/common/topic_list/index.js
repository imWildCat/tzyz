/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var TopicListRow = require('./row');

var TopicList = React.createClass({

    propTypes: {
        topics: React.PropTypes.array,
        isNodePage: React.PropTypes.bool
    },

    render: function () {

        var topicsArray = this.props.topics || [];

        var self = this;

        var list = topicsArray.map(function (e) {
            return (
                <TopicListRow isNodePage={self.props.isNodePage} topic={e} key={'t_' + e.id}/>
            );
        });

        return (
            <div className="topic-list">
                {list}
            </div>
        )
    }
});

module.exports = TopicList;