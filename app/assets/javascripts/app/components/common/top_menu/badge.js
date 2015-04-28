var React = require('react');

var style = {
    div: {
        width: 15,
        height: 15,
        display: 'inline-block',
        backgroundColor: '#E74C3C',
        fontSize: 11,
        //fontWeight: 'bold',
        borderRadius: 8,
        textAlign: 'center',
        position: 'relative',
        top: -33,
        left: 12
    },
    span: {
        display: 'block',
        marginTop: -2
    }
};

var Badge = React.createClass({
    render: function () {
        return (
            <div style={style.div}>
            <span style={style.span}>{this.props.num}</span>
            </div>
        )
    }
});


module.exports = Badge;