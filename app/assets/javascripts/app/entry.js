var React = require('react');
var Router = require('react-router');
var { Route, Redirect, RouteHandler, Link, DefaultRoute } = Router;

var injectTapEventPlugin = require("react-tap-event-plugin");
injectTapEventPlugin(); // for mobile device

var TopMenu = require('./components/common/top_menu');
var MobileMenu = require('./components/common/mobile_menu');

var HomePage = require('./components/pages/home');
var TopicShowPage = require('./components/pages/topic/show');
var NodeShowPage = require('./components/pages/node/show');
var UserShowPage = require('./components/pages/user/show');

var MainBlurContainer = require('./components/top_level/main_blur_container');

var SiteNetworkingActions = require('./actions/networking/site');

var App = React.createClass({

    componentWillMount: function() {
        SiteNetworkingActions.getInitialData();
    },

    render: function () {

        return (
            <div>
                <MainBlurContainer>
                    <TopMenu />

                    <RouteHandler/>

                </MainBlurContainer>
                <MobileMenu />
            </div>
        )
    }
});



var routes = (
    <Route name="app" path="/" handler={App}>
        <DefaultRoute name="home" handler={HomePage}/>
        <Route name="topicShow" path="topic/:id" handler={TopicShowPage} />
        <Route name="nodeShow" path="node/:slug" handler={NodeShowPage} onEnter={nodeShowPageTransitionHandler} />
        <Route name="userShow" path="user/:id" handler={UserShowPage} />
    </Route>
);

var nodeShowPageTransitionHandler = function(transition) {
    // could also check transition.path
    console.log('show');
}

Router.run(routes, function(Handler) {
    React.render(<Handler />, document.body);
});
