/**
 * Created by WildCat on 04/05/15, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var FortuneLabel = React.createClass({

    propTypes: {
        count: React.PropTypes.number
    },

    render: function () {

        var count = this.props.count;
        var copperCount = count % 100;
        var silverCount = parseInt((count / 100) % 100);
        var goldCount = parseInt((count / 10000) % 100);

        return (
            <span className="fortune-label">
            </span>
        )
    }
});

module.exports = FortuneLabel;