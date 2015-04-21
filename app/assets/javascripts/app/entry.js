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

var App = React.createClass({displayName: "App",

    componentWillMount: function() {
        SiteNetworkingActions.getInitialData();
    },

    render: function () {

        return (
            React.createElement("div", null, 
                React.createElement(MainBlurContainer, null, 
                    React.createElement(TopMenu, null), 

                    React.createElement(RouteHandler, null)

                ), 
                React.createElement(MobileMenu, null)
            )
        )
    }
});



var routes = (
    React.createElement(Route, {name: "app", path: "/", handler: App}, 
        React.createElement(DefaultRoute, {name: "home", handler: HomePage}), 
        React.createElement(Route, {name: "topicShow", path: "topic/:id", handler: TopicShowPage}), 
        React.createElement(Route, {name: "nodeShow", path: "node/:slug", handler: NodeShowPage, onEnter: nodeShowPageTransitionHandler}), 
        React.createElement(Route, {name: "userShow", path: "user/:id", handler: UserShowPage})
    )
);

var nodeShowPageTransitionHandler = function(transition) {
    // could also check transition.path
    console.log('show');
}

Router.run(routes, function(Handler) {
    React.render(React.createElement(Handler, null), document.body);
});

//# sourceMappingURL=entry.js.map
//# sourceMappingURL=entry.js.map