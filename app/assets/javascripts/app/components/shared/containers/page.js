/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');

var Card = require('./card');
var SideBar = require('../../common/side_bar');

var Page = React.createClass({

    render: function () {

        var className = 'page';
        if (this.props.className) {
            className += ' ' + this.props.className;
        }

        return (
            <div {...this.props} className={className}>
                <div className="left-col">
                {this.props.children}
                </div>
                <div className="right-col">
                    <SideBar />
                </div>
            </div>
        )
    }
});

module.exports = Page;