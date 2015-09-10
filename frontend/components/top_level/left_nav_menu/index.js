/**
 * Created by WildCat on 28/04/15, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var { LeftNav } = require('material-ui');

var LogoutConfirmationDialogActions = require('../../../actions/dialogs/logout_confirmation');

var LeftNavMenuStore = require('../../../stores/left_nav_menu');

var LeftNavMenu = React.createClass({

    mixins: [
        Reflux.listenTo(LeftNavMenuStore, 'onStoreUpdate')
    ],

    onStoreUpdate: function () {
        this.refs.nav.toggle();
    },

    onNavChange: function (e, selectedIndex, menuItem) {
        //this.refs.nav.toggle();
        switch (selectedIndex) {
            case 0:
                LogoutConfirmationDialogActions.show();
                break;
            default:
                return;
        }
    },

    //componentDidMount: function() {
    //  this.refs.nav.toggle();
    //},

    render: function () {

        var menuItems = [
            {route: 'get-started', text: '注销'},
            //{ route: 'css-framework', text: 'CSS Framework' },
            //{ route: 'components', text: 'Components' },
            //{ type: MenuItem.Types.SUBHEADER, text: 'Resources' },
            //{
            //    type: MenuItem.Types.LINK,
            //    payload: 'https://github.com/callemall/material-ui',
            //    text: 'GitHub'
            //},
            //{
            //    text: 'Disabled',
            //    disabled: true
            //},
            //{
            //    type: MenuItem.Types.LINK,
            //    payload: 'https://www.google.com',
            //    text: 'Disabled Link',
            //    disabled: true
            //}
        ];

        return ( 
            <LeftNav ref="nav" isInitiallyOpen={false} docked={false} menuItems={menuItems} onChange={this.onNavChange}/>
        )
    }
});

module.exports = LeftNavMenu;