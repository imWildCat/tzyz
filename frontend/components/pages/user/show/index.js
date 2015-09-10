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
                    <div className="header">
                        <div className="avatar-wrapper">
                            <Avatar mode="big" url={user.avatar_url}/>
                        </div>
                        <div className="info-wrapper">
                            <div className="actions">
                                <span><i className="fa fa-eye-slash"></i></span>
                                <span><i className="fa fa-envelope"></i></span>
                                <span># {user.id}</span>
                            </div>

                            <div className="username">{user.display_name}</div>
                            <div className="headline">{user.profile.headline}</div>
                        </div>
                    </div>

                    <div className="content-wrapper">
                        <ul className="tab-menu">
                            <li className="active">资料</li>
                            <li>话题</li>
                            <li>回复</li>
                        </ul>

                        <div className="tab-container">
                            <table className="user-profile-content">
                                <tbody>
                                <tr>
                                    <th>城市</th>
                                    <td>{user.profile.city}</td>
                                </tr>
                                <tr>
                                    <th>所在行业</th>
                                    <td>{user.profile.field}</td>
                                </tr>
                                <tr>
                                    <th>毕业院校</th>
                                    <td>{user.profile.university}</td>
                                </tr>
                                <tr>
                                    <th>个人网站</th>
                                    <td>{user.profile.website}</td>
                                </tr>
                                <tr>
                                    <th>QQ</th>
                                    <td>{user.profile.qq}</td>
                                </tr>
                                <tr>
                                    <th>微博</th>
                                    <td>{user.profile.weibo}</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
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