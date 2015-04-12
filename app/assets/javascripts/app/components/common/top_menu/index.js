var React = require('react');

var Avatar = require('./avatar');
var Badge = require('./badge');
var SearchField = require('./search_field');

var Colors = require('../colors');

var styles = {
    rightBar: {
        margin: 0,
        padding: 0
    },

};


var TopMenu = React.createClass({
    render: function () {
        return (
            <nav id="top-menu">
                <div className="wrapper">
                    <i className="logo"></i>
                    <div className="brand">
                        <h1>滕州一中校友会</h1>
                    </div>
                    <ul className="menu hidden-sm">
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
                    <ul className="right-bar" style={styles.rightBar}>
                        <li className="item hidden-sm">
                            <i className="fa fa-users icon"></i>
                        </li>
                        <li className="item">
                            <i className="fa fa-bell icon"></i>
                            <Badge num="1" />
                        </li>
                        <li className="item">
                            <Avatar url="/assets/no_avatar.png" />
                        </li>
                    </ul>
                    <SearchField />
                </div>
            </nav>
        )
    }
});

module.exports = TopMenu;