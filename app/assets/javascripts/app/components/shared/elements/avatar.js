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
            case 'medium':
                className += ' medium'; // 40px with corner-radius: 5
                break;
            case 'big':
                className += ' big'; // 60px rounded
                break;
            default:
                // do nothing, default size is 40px * 40px
        }

        var onTouchTap = null;
        if (this.props.onTouchTap) {
            onTouchTap = this.props.onTouchTap;
        }

        var url = this.props.url;
        if (url.indexOf('/assets/no_avatar.png') == 0) {
            url = '//ww3.sinaimg.cn/large/7deee1d1tw1erkiilrqamj205k05kmwy.jpg';
        }

        return (
            <img  onTouchTap={onTouchTap} src={url} className={className} alt="avatar" />
        )
    }
});

module.exports = Avatar;