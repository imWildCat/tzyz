var React = require('react');

var DefaultMask = React.createClass({

    render: function () {

        return (
            <div {...this.props} className={'default-mask ' + this.props.className}>
                {this.props.children}
            </div>
        )
    }
});


module.exports = DefaultMask;