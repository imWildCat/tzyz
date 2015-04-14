/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var TabMenu = React.createClass({
    render: function() {
        return (
            <ul {...this.props} className={'tab-menu ' + this.props.className}>
                <li className="active">
                    <a>社区</a>
                </li>
                <li>
                    <a>节点</a>
                </li>
                <li>
                    <a>活动</a>
                </li>
                <li>
                    <a>关于</a>
                </li>
            </ul>
        )
    }
});


module.exports = TabMenu;