# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# $(document).ready(-> 
  # window.portfolio()
# )

window.portfolio = (start = null) ->
 
  console.debug "load portfolio"
  
  container = $('#portfolio_container')
  impress_container = $('#impress_container')
  # $('.step').height(window.height() - 100)
  impress_container.jmpress("route", ".basic");
  impress_container.jmpress("route", ".anilib");
  
  options = {
              start: "ciao"
            }
            
  console.log "options : " + options       
  
  impress_container.jmpress(options)
  #impress_container.afterInit( -> 
  $('.step').hide()
  $('.step.active').fadeIn(500)
  #)
  
  $('.step').on('enterStep', (event) -> 
    $(this).fadeIn(500)
  ).on('leaveStep', (event) ->
    $(this).fadeOut(1000)
  );
  
  $('#left_arrow').fadeIn('slow').click(-> impress_container.jmpress('prev'))
  $('#right_arrow').fadeIn('slow').click(-> impress_container.jmpress('next'))
  
  $('a.home').click( (e) ->
    e.preventDefault() 
    back_to_home()
  )
  
  
back_to_home = -> 
  $.get('/?layout=false' , (data) ->
    $('#container').html(data)
    window.load_home()
  )
  