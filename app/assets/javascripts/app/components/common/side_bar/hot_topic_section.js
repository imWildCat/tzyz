/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var HotTopicStore = require('../../../stores/site/hot_topic');

var Section = require('./section');
var Avatar = require('../../shared/elements/avatar');

var Row = React.createClass({

    Prototype: {
        topic: React.PropTypes.object
    },

    render: function () {
        var topic = this.props.topic;
        return (
            <div className="row" style={{clear: 'both', padding: '10px 16px 10px 16px', borderBottom: '1px solid #dbdbdb'}}>
                <div className="wrapper">
                    <div className="avatar-wrapper" style={{width: 24, height: 24, float: 'left'}}>
                        <Avatar mode="tiny" url={topic.author.avatar_url} />
                    </div>
                    <div className="title" style={{marginLeft: 34, width: 'auto', minHeight: 24}}>
                        {topic.title}
                    </div>
                </div>
            </div>
        )
    }
});


var HotTopicSection = React.createClass({

    mixins: [
        Reflux.listenTo(HotTopicStore, 'onStoreUpdate')
    ],

    getInitialState: function () {
        return { hotTopics: HotTopicStore.get() }
    },

    onStoreUpdate: function (hotTopics) {
        this.setState({hotTopics: hotTopics});
    },

    render: function () {

        var header = '<h2>热议话题</h2>';

        var list = this.state.hotTopics.map(function (e) {
            return (
                <Row topic={e} key={'t_' + e.id} />
            );
        });

        return (
            <Section header={header}>
                {list}
            </Section>
        )
    }
});

module.exports = HotTopicSection;