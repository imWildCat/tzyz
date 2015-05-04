var React = require('react');
var Reflux = require('reflux');
var UnreadNotificationStore = require('../../../stores/site/unread_notification');

var style = {
    span: {
        display: 'block',
        marginTop: -2
    }
};

var Badge = React.createClass({

    //propTypes: {
    //    num: React.PropTypes.number
    //},

    mixins: [
        Reflux.listenTo(UnreadNotificationStore, 'onStoreUpdate')
    ],

    getInitialState: function () {
        return {num: UnreadNotificationStore.getCount()}
    },

    onStoreUpdate: function (newCount) {
        this.setState({num: newCount});
    },

    render: function () {
        var className = 'badge';
        if (this.state.num < 1) {
            className += ' hidden';
        }

        return (
            <div className={className} style={style.div}>
                <span style={style.span}>{this.state.num}</span>
            </div>
        )
    }
});


module.exports = Badge;