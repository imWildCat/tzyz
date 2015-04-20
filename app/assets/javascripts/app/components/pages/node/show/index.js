/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var Card = require('../../../shared/containers/card');
var Page = require('../../../shared/containers/page');
var TopicList = require('../../../common/topic_list');

var NodeNetworkingActions = require('../../../../actions/networking/node');
var CurrentNodeStore = require('../../../../stores/node/current');

var NodeShowPage = React.createClass({

    contextTypes: {
        router: React.PropTypes.func
    },

    mixins: [
        Reflux.listenTo(CurrentNodeStore, 'onStoreUpdate')
    ],

    componentWillMount: function () {
        var { slug } = this.context.router.getCurrentParams();

        NodeNetworkingActions.getSingle(slug, 1);
    },

    getInitialState: function () {
        return {node: {}, topics: []}
    },

    onStoreUpdate: function (data) {
        this.setState(data);
    },

    render: function() {
        return (
            <Page id="node-page">
                <Card autoPadding={true} style={{marginBottom: 20}}>
                    <h3 style={{margin: 0}}>{this.state.node.name}</h3>
                </Card>
                <Card><TopicList isNodePage={true} topics={this.state.topics}/></Card>
            </Page>
        )
    }
});

module.exports = NodeShowPage;