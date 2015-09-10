/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');
var merge = require('merge');

var FlatButton = React.createClass({

    render: function () {

        var label = this.props.label || '';

        return (
            <div {...this.props} style={merge({display: 'inline-block'}, this.props.style)}>
                {this.props.children}
                {label}
            </div>
        )
    }
});


module.exports = FlatButton;