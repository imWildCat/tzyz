/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var HotTopicSection = require('./hot_topic_section');
var NodeSction = require('./node_section');
var StatisticsSection = require('./statistics');

var SideBar = React.createClass({

    render: function() {
        return (
            <aside {...this.props} className="side-bar">
                <HotTopicSection />
                <NodeSction />
                <StatisticsSection />
            </aside>
        )
    }
});

module.exports = SideBar;