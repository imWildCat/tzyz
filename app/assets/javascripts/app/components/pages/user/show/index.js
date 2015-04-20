/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var Card = require('../../../shared/containers/card');
var Page = require('../../../shared/containers/page');
var TopicList = require('../../../common/topic_list');

var UserNetworkingActions = require('../../../../actions/networking/user');
var CurrentUserStore = require('../../../../stores/user/current');

var UserShowPage = React.createClass({

    contextTypes: {
        router: React.PropTypes.func
    },

    mixins: [
        Reflux.listenTo(CurrentUserStore, 'onStoreUpdate')
    ],

    componentWillMount: function () {
        var { id } = this.context.router.getCurrentParams();

        UserNetworkingActions.getSingle(id);
    },

    getInitialState: function () {
        return {user: {}}
    },

    onStoreUpdate: function (data) {
        this.setState({user: data});
    },

    render: function() {
        return (
            <Page id="user-show-page">
                <Card autoPadding={true} style={{marginBottom: 20}}>
                    {this.state.user.display_name}
                    1
                </Card>

            </Page>
        )
    }
});

module.exports = UserShowPage;