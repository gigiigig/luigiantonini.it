# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready( ->
  
  #se mimum height of ocntainer
  $('#container').css('min-height' , $(window).height())
  
  #prevent mouse scroll during animation
  $(document).on('mousewheel' , (e, aS, aQ, deltaY) ->    
    if bodyAnimated()
      e.preventDefault() 
  )
  
  

  window.loadNavigation()
  window.loadHome()
  window.loadIsotope()
  
  #load all links wick use fancy box
  #this load also curriculum menu item
  $('a.fancybox').fancybox()
  
  #old browser message
  if(!Modernizr.csstransforms3d)
    $('#show_browser_message').trigger('click')
  
)

#some general functions
window.scroll = -> $(window).scrollTop()
    
old_scroll = 0
window.scrollDir = ->
  to_return = true
  if(scroll() < old_scroll)
    to_return = false
  old_scroll = scroll()
  to_return
  

window.hash = (url) ->
  window.location.hash = url
  
#reset styles addeds from jmpress
window.resetBody = ->
  $('body,html').removeAttr('style')

window.bodyAnimated = ->
  $('body').is(':animated') || $('html').is(':animated')   
