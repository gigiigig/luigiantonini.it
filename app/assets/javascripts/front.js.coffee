# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready( ->
  
 
  $(document).scroll( ->
 
    scroll = $(window).scrollTop()
    top_bar = $('.navbar-inner ul.nav')
    brand = $('.brand')
    padding =  20 - (scroll / 4)
    
    if padding < 0 then padding = 0

    font_size = 20 + (padding * 0.8)


    #top_bar.animate({
    #  height: height
    #},1000)

    top_bar.css("padding-top" , padding)
    brand.css("font-size" , font_size)
    brand.html(scroll)
    
    home_message = $("#home_message")
    technologies = $(".technologies")
    
    if scroll >= 396  
      home_message.addClass('fixed') 
      technologies.css('margin-top' , 162)
      
      if scroll >= 1200
        home_message.css('top' , 1220 - scroll)
        
        if scroll >= 1328
          $('#portfolio').addClass('fixed')
        else   
          $('#portfolio').removeClass('fixed')
          
    else 
      home_message.removeClass("fixed")
      technologies.css('margin-top' , 20) 
    
  )
  
  $('a.fancybox').fancybox()

)
