/**
 * Created by WildCat on 01/05/15, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var NodeCategoryNetworkingActions = require('../../../../actions/networking/node_category');
var NodeCategoryStore = require('../../../../stores/node_category');

var Chosen = require('../../../shared/elements/chosen');

var NodeChosen = React.createClass({

    Prototype: {
        onChange: React.PropTypes.func
    },

    mixins: [
            Reflux.listenTo(NodeCategoryStore, 'onStoreUpdate')
    ],

    onStoreUpdate: function(data) {
        this.setState({
            categories: data
        });
    },

    getInitialState: function () {
        if (NodeCategoryStore.getList().length < 1) {
            NodeCategoryNetworkingActions.getList();
        }

        return {
            categories: NodeCategoryStore.getList()
        }
    },

    onChange: function (a, b, c) {
        var nodeID = parseInt(b.selected);
        this.props.onChange && this.props.onChange(nodeID);
    },

    render: function () {

        var options = this.state.categories.map(function (nodeCategory) {

            var nodes = nodeCategory.nodes.map((node) => {
               return (
                   <option value={node.id} key={'node_' + node.id}>{node.name}</option>
               );
            });

            return (
                <optgroup key={'node_cat_' + nodeCategory.id} label={nodeCategory.name}>
                    {nodes}
                </optgroup>
            );
        });


        return (
            <Chosen width={25} onChange={this.onChange} noResultsText="未找到相关节点">
                <option value="0">选择节点</option>
                {options}
            </Chosen>
        )
    }
});

module.exports = NodeChosen;