var React = require('react');

var TopMenu = require('./components/common/top_menu');
var MobileMenu = require('./components/common/mobile_menu');

var MainBlurContainer = require('./components/top_level/main_blur_container');

var App = React.createClass({
    render: function () {

        return (
            <div>
                <MainBlurContainer>
                    <TopMenu />
                </MainBlurContainer>

                <MobileMenu />

            </div>
        )
    }
});


React.render(<App />, document.body);