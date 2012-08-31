# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready( ->
  
  $(document).scroll( ->
    top_bar = $('#top_bar')

    top_bar
    height = 80 - ($(window).scrollTop() / 4)

    if height < 40 then height = 40

    #top_bar.animate({
    #  height: 40
    #},1000)

    top_bar.height(height)
  )

)
