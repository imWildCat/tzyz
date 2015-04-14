var React = require('react');

var styles = {
    inputStyle: {
        marginLeft: 10,
        width: 135,
        fontSize: 14,
        backgroundColor: 'transparent',
        border: 'none',
        color: '#ffffff',
        marginTop: 5
    }
};

var SearchField = React.createClass({
    render: function () {
        var className = this.props.className || '';
        return (
            <div {...this.props} className={'search-field ' + className}>
                <input type="text" style={styles.inputStyle} />
                <i className="fa fa-search top-menu-icon" style={{marginTop: -3, marginLeft: 10}}></i>
            </div>
        )
    }
});


module.exports = SearchField;