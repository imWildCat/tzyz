# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require jquery.timeago
#= require jquery.timeago.settings
#= require turbolinks
#= require nprogress
#= require nprogress-turbolinks
#= require bootstrap
#= require pen.js
#= require pen/markdown
#= require pen_editor
#= require_tree .

# nprogress
NProgress.configure({
  showSpinner: false,
  ease: 'ease',
  speed: 500
})

# Rails 4: how to use $(document).ready() with turbo-links
# http://stackoverflow.com/questions/18770517/rails-4-how-to-use-document-ready-with-turbo-links
readyCb = ->
  # time ago
  $('abbr.timeago').timeago();
  # hack breadcrumb
  $('.breadcrumb li').last().addClass('active');

$(document).ready readyCb
$(document).on 'page:load', readyCb

jQuery.fn.extend
  scrollToMe: (duration) ->
    duration = duration or 200
    x = jQuery(this).offset().top - 100
    jQuery('html,body').animate({scrollTop: x}, duration)