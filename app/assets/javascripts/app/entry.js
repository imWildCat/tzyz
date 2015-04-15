var React = require('react');

var injectTapEventPlugin = require("react-tap-event-plugin");
injectTapEventPlugin(); // for mobile device

var TopMenu = require('./components/common/top_menu');
var MobileMenu = require('./components/common/mobile_menu');

var HomePage = require('./components/pages/home');

var MainBlurContainer = require('./components/top_level/main_blur_container');

var App = React.createClass({
    render: function () {

        return (
            <div>
                <MainBlurContainer>
                    <TopMenu />
                    <HomePage />
                </MainBlurContainer>
                <MobileMenu />
            </div>
        )
    }
});


React.render(<App />, document.body);