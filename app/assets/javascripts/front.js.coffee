# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready( ->
  
  topBar(0)
  
  $('a.portfolio').click( (e) ->
    e.preventDefault() 
    scrollToVal(1462))  
  
  message_hidden = false
  home_image = $('#home_image')
  home_image_original_height = home_image.height()  
  
  $(document).scroll( ->
    
    scroll = $(window).scrollTop()
    topBar(scroll)
    
    if(scroll < 500)
      homeImage(scroll ,home_image_original_height , home_image)
    
    home_message = $("#home_message")
    technologies = $(".technologies")
    
    if scroll >= 528  
      home_message.addClass('fixed') 
      technologies.css('margin-top' , 162)
      technologies.addClass('color')
      
      if scroll >= 1300
        #home_message.css('top' , 1220 - scroll)
        if(!message_hidden)
          home_message.stop(true).animate({'top' : -110} , 1000 , -> )
          message_hidden = true
          
        if scroll >= 1450
          $('#portfolio').addClass('fixed')
          $('.works').css('margin-top' , 137)
        else   
          $('#portfolio').removeClass('fixed')
          $('.works').css('margin-top' , 20)
          
      else
      
        if(message_hidden)
          home_message.stop(true).animate({ 'top' : 10 } , 1000 , -> )
          message_hidden = false
          
    else 
      home_message.removeClass("fixed")
      technologies.css('margin-top' , 20) 
      technologies.removeClass('color')
    
  )
  
  $('a.fancybox').fancybox()

)

homeImage = (scroll , original_height  ,container) ->
    
  container.height(original_height - scroll / 1.7)
  container.css('margin-top' , -10 + scroll / 1.2)
  if scroll == 0
    container.removeClass('with_shadow')
  else
    container.addClass('with_shadow')
  
topBar = (scroll) -> 
  
  top_bar = $('.navbar-inner ul.nav')
  brand = $('.brand')
  
  padding = 20
  font_size = 20 + (padding * 0.8)
  
  top_bar.css("padding-top" , padding)
  brand.css("font-size" , font_size)
  brand.css("padding-top" , 8 + padding / 4)
 
  padding =  20 - (scroll / 4)
  
  if padding < 0 then padding = 0

  font_size = 20 + (padding * 0.8)

  #top_bar.animate({
  #  height: height
  #},1000)

  top_bar.css("padding-top" , padding)
  brand.css("font-size" , font_size)
  brand.css("padding-top" , 8 + padding / 4)
  brand.html(scroll)


scrollTo = (id) ->
  
  $('html,body').animate(
    {scrollTop: $("##{id}").offset().top} , 3000, 'easeInOutExpo'
  )  
  
scrollToVal = (val) ->
  $('html,body').animate(
    {scrollTop: val} , 3000, 'easeInOutExpo'
  )  

