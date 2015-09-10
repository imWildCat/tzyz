/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var BlurContainer = React.createClass({

    render: function () {

        var defaultClass = 'blur-container';
        if (this.props.className) {
            defaultClass += ' ' + this.props.className;
        }

        return (
            <div {...this.props} className={defaultClass}>
                {this.props.children}
            </div>
        )
    }
});

module.exports = BlurContainer;