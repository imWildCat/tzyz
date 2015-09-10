/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');
var { Link } = require('react-router');

var HotNodeStore = require('../../../stores/site/hot_node');
var NewNodeStore = require('../../../stores/site/new_node');

var Section = require('./section');

var Row = React.createClass({

    propTypes: {
        node: React.PropTypes.object
    },

    render: function () {
        var node = this.props.node;

        return (
            <li>
                <Link to="nodeShow" params={{slug: node.slug}}> {node.name} </Link>
            </li>
        )
    }
});

var NodeList = React.createClass({

    propTypes: {
        nodes: React.PropTypes.array
    },

    render: function () {

        var list = this.props.nodes.map((e) => {
            return <Row node={e} key={'n_' + e.id} />
        });

        return (
            <ol className="node-list">
                {list}
            </ol>
        )
    }
});

var HotNodeList = React.createClass({

    mixins: [
        Reflux.listenTo(HotNodeStore, 'onStoreUpdate'),
    ],

    onStoreUpdate: function (nodes) {
        this.setState({nodes: nodes});
    },

    getInitialState: function () {
        return {nodes: HotNodeStore.get()};
    },

    render: function () {
        return (
            <NodeList nodes={this.state.nodes} />
        )
    }
});

var NewNodeList = React.createClass({

    mixins: [
        Reflux.listenTo(NewNodeStore, 'onStoreUpdate')
    ],

    onStoreUpdate: function (nodes) {
        this.setState({nodes: nodes});
    },

    getInitialState: function () {
        return {nodes: NewNodeStore.get()};
    },

    render: function () {
        return (
            <NodeList nodes={this.state.nodes} />
        )
    }
});

var NodeSection = React.createClass({

    render: function () {

        var header = '<div style="height: 31px">' +
            '<h2 style="float:left;display: inline-block; width:40%;">活跃节点</h2>' +
            '<h2 style="float:right;display: inline-block; width:40%; margin-left: 0; margin-right: 16px; text-align: right;">新增节点</h2>' +
            '</div>';

        return (
            <Section className="nodes" style={{marginTop: 20}} header={header}>
                <div className="left">
                    <HotNodeList />
                </div>
                <div className="right">
                    <NewNodeList />
                </div>
            </Section>
        )
    }
});

module.exports = NodeSection;