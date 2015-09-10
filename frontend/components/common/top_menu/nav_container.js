/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var NavContainer = React.createClass({

    propTypes: {
      isMobile: React.PropTypes.bool
    },

    render: function () {
        var className = this.props.isMobile? 'top-menu mobile' : 'top-menu';
        return (
            <nav {...this.props} className={className}>
                <div className="wrapper">
                    {this.props.children}
                </div>
            </nav>
        )
    }
});


module.exports = NavContainer;