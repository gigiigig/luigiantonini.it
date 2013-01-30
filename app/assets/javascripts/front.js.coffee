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
  
  #load all links wick use fancy box
  #this load also curriculum menu item
  $('a.fancybox').fancybox()
  
  #explorer message
  if($.browser.msie)
    $('#show_explorer_message').trigger('click')
  #old browser message
  else if(!Modernizr.csstransforms3d)
    $('#show_browser_message').trigger('click')

  #load all scripts
  if $(window).width() >= 768  
    window.loadNavigation()
    window.loadHome()
    window.loadIsotope()
  else
    window.loadMobile()
  
  #target: '#mail_send_result'
 
  $('#contact_form').ajaxForm({
    
    beforeSubmit: -> 
      first_name = $('input[name=first_name]').val()
      last_name = $('input[name=last_name]').val()
      email = $('input[name=email]').val()
      message = $('textarea[name=email]').val()
       
      if(first_name != "" && last_name != "" && email != "" && message != "" )
        $('#mail_send_result img').show()
        true
      else
        alert "All fieds are mandatory!"
        false
    success: (responseText) ->
      $('#mail_send_result img').hide()
      $('#mail_send_result').append(responseText + "<br>")
  })
  
)

#some general functions
window.scroll = -> $(window).scrollTop()
    
old_scroll = 0
window.scrollDir = ->
  to_return = true
  if(scroll() <= old_scroll)
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
