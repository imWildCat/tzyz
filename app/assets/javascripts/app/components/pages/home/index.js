/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var Card = require('../../shared/containers/card');
var Page = require('../../shared/containers/page');
var TopicList = require('../../common/topic_list');

var TopicListStore = require('../../../stores/site/topic_list');

var HomePage = React.createClass({

    mixins: [
        Reflux.listenTo(TopicListStore, 'onStoreUpdate')
    ],

    getInitialState: function () {

        return {
            topics: TopicListStore.get()
        }
    },

    onStoreUpdate: function(data) {
        this.setState({topics: data});
    },

    render: function () {
        return (
            <Page id="home-page">
                <Card><TopicList topics={this.state.topics}/></Card>
            </Page>
        )
    }
});

module.exports = HomePage;