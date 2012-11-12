# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready(-> 
  window.portfolio()
)

window.portfolio = ->
  container = $('#portfolio_container')
  impress_container = $('#impress_container')
  impress_container.jmpress("route", ".basic");
  impress_container.jmpress("route", ".anilib");
  impress_container.jmpress()
  impress_container.afterInit( -> 
    $('.step').fadeOut();
  )
  
  $('#left_arrow').click(-> impress_container.jmpress('prev'))
  $('#right_arrow').click(-> impress_container.jmpress('next'))