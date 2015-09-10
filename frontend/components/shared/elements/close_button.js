/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');

var FlatButton = require('./flat_button');

var CloseButton = React.createClass({

    propTypes: {
        mode: React.PropTypes.string // enum: [light, dark]
    },

    render: function () {

        var className = 'fa fa-times close-button';
        if(this.props.mode === 'dark') {
            className += ' dark'
        }

        return (
            <FlatButton {...this.props}>
                <i className={className}></i>
            </FlatButton>
        )
    }
});


module.exports = CloseButton;