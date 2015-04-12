var React = require('react');

var styles = {
    inputStyle: {
        marginLeft: 10,
        width: 140,
        fontSize: 14,
        backgroundColor: 'transparent',
        border: 'none',
        color: '#ffffff',
        marginTop: 6
    }
};

var SearchField = React.createClass({
    render: function () {
        return (
            <div className="hidden-md search-field">
                <input type="text" style={styles.inputStyle} />
                <i className="fa fa-search icon" style={{marginTop: -3, marginLeft: 10}}></i>
            </div>
        )
    }
});


module.exports = SearchField;