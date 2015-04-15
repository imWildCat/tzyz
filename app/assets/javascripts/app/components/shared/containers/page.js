/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');

var Page = React.createClass({

    render: function() {

        var className = 'page';
        if(this.props.className) {
            className += ' ' + this.props.className;
        }

        return (
            <div {...this.props} className={className}>
                {this.props.children}
            </div>
        )
    }
});

module.exports = Page;