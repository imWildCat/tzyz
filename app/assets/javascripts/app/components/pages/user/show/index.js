/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var Card = require('../../../shared/containers/card');
var Page = require('../../../shared/containers/page');
var TopicList = require('../../../common/topic_list');

var Avatar = require('../../../shared/elements/avatar');

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
        this.requestData();
    },

    componentWillReceiveProps: function (nextProps) {
        this.requestData();
    },

    requestData: function () {
        var { id } = this.context.router.getCurrentParams();
        UserNetworkingActions.getSingle(id);
    },

    getInitialState: function () {
        return {user: {}}
    },

    onStoreUpdate: function (data) {
        this.setState({user: data});
    },

    render: function () {
        var user = this.state.user;

        var pageContent = <Card autoPadding={true}>加载中...</Card>
        if (user.avatar_url) {
            pageContent =
                <Card className="user-card" autoPadding={false} style={{marginBottom: 20}}>
                    <div className="avatar-wrapper">
                        <Avatar mode="big" url={user.avatar_url}/>
                    </div>
                    <div className="info-wrapper">
                        <span className="username">{user.display_name}</span>
                        <span className="headline">{user.profile.headline}</span>
                    </div>
                </Card>
        }

        return (
            <Page id="user-show-page">
                {pageContent}
            </Page>
        )
    }
});

module.exports = UserShowPage;