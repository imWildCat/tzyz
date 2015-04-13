/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var MobileMenuActions = require('../../../actions/mobile_menu_actions');
var ShouldShowStore = require('../../../stores/mobile_menu/should_show');

var DefaultMask = require('../../shared/default_mask');

var MobileMenu = React.createClass({

    mixins: [Reflux.ListenerMixin],

    getInitialState: function () {
        return {
            shouldShow: false
        }
    },

    componentDidMount: function() {
        this.listenTo(ShouldShowStore, this.onShouldShowChange);
    },

    onShouldShowChange: function(shouldShow) {
        this.setState({shouldShow: shouldShow});
    },

    onMaskClick: function() {
        MobileMenuActions.toggle();
    },

    render: function() {
        var style;
        if(this.state.shouldShow) {
            style = {
            };
        } else {
            style = {
                display: 'none'
            };
        }
        return (
            <DefaultMask style={style} className="haha" onClick={this.onMaskClick}>
                1
            </DefaultMask>
        )
    }
});


module.exports = MobileMenu;