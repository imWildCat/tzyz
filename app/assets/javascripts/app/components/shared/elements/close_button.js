/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');

var FlatButton = require('./flat_button');

var CloseButton = React.createClass({

    //propTypes: {
    //    iconClassName: React.Prototype.string
    //},

    render: function () {
        return (
            <FlatButton {...this.props}>
                <i className="fa fa-times close-button"></i>
            </FlatButton>
        )
    }
});


module.exports = CloseButton;