var React = require('react');

var style = {
    width: 15,
    height: 15,
    display: 'inline-block',
    backgroundColor: '#E74C3C',
    fontSize: 11,
    //fontWeight: 'bold',
    borderRadius: 8,
    textAlign: 'center',
    position: 'relative',
    top: -40,
    left: 12
};

var Badge = React.createClass({
    render: function () {
        return (
            <div style={style}>
            {this.props.num}
            </div>
        )
    }
});


module.exports = Badge;