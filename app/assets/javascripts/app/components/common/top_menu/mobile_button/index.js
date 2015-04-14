var React = require('react');
var MobileMenuActions = require('../../../../actions/mobile_menu_actions');

var MobileButton = React.createClass({

    onButtonClick: function () {
        MobileMenuActions.showMenu();
    },

    render: function () {

        return (
            <li className="item visible-md mobile-menu">
                <i className="fa fa-bars top-menu-icon" onTouchTap={this.onButtonClick}></i>
            </li>
        )
    }
});


module.exports = MobileButton;