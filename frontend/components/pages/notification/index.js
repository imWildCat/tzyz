/**
 * Created by WildCat on 02/05/15, all rights reserved.
 */

'use strict';


var React = require('react');
var Reflux = require('reflux');

var NotificationNetworkingActions = require('../../../actions/networking/notification');
var NotificationListStore = require('../../../stores/notification/list');
var SessionUserStore = require('../../../stores/site/session_user');

var Page = require('../../shared/containers/page');
var Card = require('../../shared/containers/card');

var UserMeta = require('../../shared/elements/user_meta');
var NotificationRow = require('./row');

var NotificationPage = React.createClass({

    contextTypes: {
        router: React.PropTypes.func
    },

    getInitialState: function () {
        NotificationNetworkingActions.getList();
        return {
            list: []
        }
    },

    mixins: [
        Reflux.listenTo(NotificationListStore, 'onStoreUpdate'),
        Reflux.listenTo(SessionUserStore, 'onSessionUserStoreUpdate')
    ],

    onStoreUpdate: function (list) {
        this.setState({list: list, user: this.state.user});
    },

    onSessionUserStoreUpdate: function (user) {
        this.setState({list: this.state.list, user: user});
    },

    render: function () {

        var nList = this.state.list.map((n) => {
            return <NotificationRow notification={n} key={'n_' + n.id}/>
        });

        var avatarURL = this.state.user? this.state.user.avatar_url : '/assets/no_avatar.png';

        return (
            <Page id="notification-page">
                <Card>
                    <UserMeta title="通知中心" />
                    {nList}
                </Card>
            </Page>
        )
    }
});

module.exports = NotificationPage;