var React = require('react');
var Router = require('react-router');
var { Route, Redirect, RouteHandler, Link, DefaultRoute } = Router;

var injectTapEventPlugin = require("react-tap-event-plugin");
injectTapEventPlugin(); // for mobile device

// inject zh-cn language
var momentZhCn = require('moment/locale/zh-cn');

var TopMenu = require('./components/common/top_menu');
var MobileMenu = require('./components/common/mobile_menu');
var Dialogs = require('./components/top_level/dialogs');
var GlobalSnackbar = require('./components/top_level/global_snackbar');
var LeftNavMenu = require('./components/top_level/left_nav_menu');

var HomePage = require('./components/pages/home');
var TopicShowPage = require('./components/pages/topic/show');
var NodeShowPage = require('./components/pages/node/show');
var UserShowPage = require('./components/pages/user/show');
var NotificationPage = require('./components/pages/notification');

var MainBlurContainer = require('./components/top_level/main_blur_container');

var SiteNetworkingActions = require('./actions/networking/site');

var App = React.createClass({

    componentWillMount: function () {
        SiteNetworkingActions.getInitialData();
    },

    render: function () {

        return (
            <div>
                <MainBlurContainer>
                    <TopMenu />

                    <RouteHandler/>

                    <div className="footer"
                         style={{paddingTop: 16, clear: 'both',width: '100%',height: 40, fontSize: 12, textAlign: 'center'}}>
                        Copyright © 2015 滕州一中校友会 1.1 Alpha
                    </div>
                </MainBlurContainer>
                <MobileMenu />
                <Dialogs />
                <GlobalSnackbar />
                <LeftNavMenu />
            </div>
        )
    }
});

var routes = (
    <Route name="app" path="/" handler={App}>
        <DefaultRoute name="home" handler={HomePage}/>
        <Route name="topicShow" path="topic/:id" handler={TopicShowPage}/>
        <Route name="nodeShow" path="node/:slug" handler={NodeShowPage}/>
        <Route name="userShow" path="user/:id" handler={UserShowPage}/>
        <Route name="notifications" path="notifications" handler={NotificationPage}/>
    </Route>
);


Router.run(routes, function (Handler) {
    React.render(<Handler />, document.body);
});