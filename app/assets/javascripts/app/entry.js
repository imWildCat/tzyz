var React = require('react');
var Router = require('react-router');
var { Route, Redirect, RouteHandler, Link, DefaultRoute } = Router;

var injectTapEventPlugin = require("react-tap-event-plugin");
injectTapEventPlugin(); // for mobile device

var TopMenu = require('./components/common/top_menu');
var MobileMenu = require('./components/common/mobile_menu');
var LoginDialog = require('./components/top_level/login_dialog');

var HomePage = require('./components/pages/home');
var TopicShowPage = require('./components/pages/topic/show');
var NodeShowPage = require('./components/pages/node/show');
var UserShowPage = require('./components/pages/user/show');

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
                         style={{paddingTop: 16, clear: 'both',width: '100%',height: 25, fontSize: 12, textAlign: 'center'}}>
                        Copyright © 2015 滕州一中校友会 1.1 Alpha
                    </div>
                </MainBlurContainer>
                <MobileMenu />
                <LoginDialog />
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
    </Route>
);


Router.run(routes, function (Handler) {
    React.render(<Handler />, document.body);
});