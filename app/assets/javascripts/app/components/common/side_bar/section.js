/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var Card = require('../../shared/containers/card');

var SideBarSection = React.createClass({

    propTypes: {
        header: React.PropTypes.string
    },

    render: function () {

        return (
            <section {...this.props}>
                <Card>
                    <div className="header" dangerouslySetInnerHTML={{__html: this.props.header}}>
                    </div>
                    <div className="content">
                        {this.props.children}
                    </div>
                </Card>
            </section>
        )
    }
});

module.exports = SideBarSection;