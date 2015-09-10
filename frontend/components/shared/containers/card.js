/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var Card = React.createClass({

    propTypes: {
      autoPadding: React.PropTypes.bool
    },

    render: function() {

        var className = 'card';
        if(this.props.className) {
            className += ' ' + this.props.className;
        }
        if(this.props.autoPadding) {
            className += ' auto-padding';
        }

        return (
            <div {...this.props} className={className}>
                {this.props.children}
            </div>
        )
    }
});


module.exports = Card;