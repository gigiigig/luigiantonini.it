# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready( ->
  $('#container').css('min-height' , $(window).height())
  window.load_home()
)

window.hash = (url) ->
  window.location.hash = url
