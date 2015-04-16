/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var StatisticsStore = require('../../../stores/site/statistics');

var Section = require('./section');

var Statistics = React.createClass({

    getInitialState: function() {
        return {statistics: StatisticsStore.get()};
    },

    mixins: [
        Reflux.listenTo(StatisticsStore, 'onStoreUpdate')
    ],

    onStoreUpdate: function (data) {
        this.setState({statistics: data});
    },

    render: function () {

        var header = '<h2>运行状态</h2>';

        var statistics = this.state.statistics;

        return (
            <Section className="statistics" style={{marginTop: 20}} header={header}>
                <div className="left">
                    <p>会员</p>
                    <p>话题</p>
                    <p>回复</p>
                </div>
                <div className="right">
                    <p>{statistics.user_count}</p>
                    <p>{statistics.topic_count}</p>
                    <p>{statistics.reply_count}</p>
                </div>
            </Section>
        )
    }
});

module.exports = Statistics;