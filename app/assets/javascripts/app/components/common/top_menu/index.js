var React = require('react');
var Reflux = require('reflux');

var { Link } = require('react-router');

var NavContainer = require('./nav_container');
var SearchField = require('./search_field');
var TabMenu = require('./tab_menu');

var ToolBar = require('./tool_bar');

var TopMenu = React.createClass({

    render: function () {
        return (
            <NavContainer>
                <i className="logo"></i>

                <div className="brand">
                    <h1><Link to="home"> 滕州一中校友会</Link></h1>
                </div>
                <TabMenu className="hidden-sm" style={{marginLeft: 30}}/>
                <ToolBar {...this.props} />
                <SearchField className="hidden-md"/>
            </NavContainer>
        )
    }
});

module.exports = TopMenu;