var React = require('react');

var styles = {
    img: {
        width: 30,
        height: 30,
        borderRadius: 5
    }
};

var Avatar = React.createClass({
    render: function() {
        return (
            <img src={this.props.url} style={styles.img} alt="top-menu-avatar" />
        )
    }
});


module.exports = Avatar;