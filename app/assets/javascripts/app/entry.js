var React = require('react');

var TopMenu = require('./components/common/top_menu');

var App = React.createClass({
   render: function() {
       return (
           <div>
               <TopMenu />
           </div>
       )
   }
});


React.render(<App />, document.body);