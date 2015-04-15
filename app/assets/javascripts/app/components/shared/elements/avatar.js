var React = require('react');

var styles = {
    img: {
        width: 30,
        height: 30,
        borderRadius: 5
    }
};

var Avatar = React.createClass({

    propTypes: {
        mode: React.PropTypes.string, // null / small
        url: React.PropTypes.string
    },

    render: function () {

        var className = 'avatar';

        switch (this.props.mode) {
            case 'small':
                className += ' small'; // 30px
                break;
            case 'tiny':
                className += ' tiny'; // 24px
                break;
            default:
                // do nothing, default size is 40px * 40px
        }

        return (
            <img src={this.props.url} className={className} alt="avatar" />
        )
    }
});


module.exports = Avatar;