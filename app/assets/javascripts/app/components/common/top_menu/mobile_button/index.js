var React = require('react');
var MobileMenuActions = require('../../../../actions/mobile_menu_actions');
var MainBlurContainerActions = require('../../../../actions/blur_containers/main');

var MobileButton = React.createClass({

    onButtonClick: function () {
        //MobileMenuActions.toggle();
        MainBlurContainerActions.performBlur();
    },

    render: function () {

        return (
            <li className="item visible-md mobile-menu">
                <i className="fa fa-bars icon" onClick={this.onButtonClick}></i>
            </li>
        )
    }
});


module.exports = MobileButton;