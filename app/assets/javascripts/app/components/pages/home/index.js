/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var Page = require('../../shared/containers/page');
var Card = require('../../shared/containers/card');
var TopicList = require('../../common/topic_list');

var TopicService = require('../../../services/topic');

var HomePage = React.createClass({

    getInitialState: function() {

        TopicService.getDefaultList(1).then((res) => {
            console.log(res.body);
            this.setState({topics: res.body});
        });

        return {
            topics: []
        }
    },

    render: function() {
        console.log('render');
        return (
            <Page id="home-page">
                <Card className="left-col" style={{/*marginTop: 20 */}}>
                    <TopicList topics={this.state.topics} />
                </Card>
            </Page>
        )
    }
});

module.exports = HomePage;