/**
 * Created by wildcat, all rights reserved.
 */

'use strict';

var React = require('react');
var Reflux = require('reflux');

var BlurContainer = require('../../shared/blur_container');
var BlurContainerActions = require('../../../actions/blur_containers/main');
var MainBlurContainerStore = require('../../../stores/blur_containers/main');

var MainBlurContainer = React.createClass({

    mixins: [Reflux.ListenerMixin],

    componentDidMount: function() {
        this.listenTo(MainBlurContainerStore, this.onBlurredChanged);
    },

    onBlurredChanged: function(blurred) {
        if(blurred) {
            $('#main-blur-container').addClass('blurred');
        } else {
            $('#main-blur-container').removeClass('blurred');
        }
    },


    render: function() {
        return (
            <BlurContainer id="main-blur-container" {...this.props}>
                {this.props.children}
            </BlurContainer>
        )
    }
});


module.exports = MainBlurContainer;