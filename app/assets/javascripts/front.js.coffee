# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready( ->
  
  home_message_fixed_at = 420
  home_message_hidden_at = 1150
  portfolio_fixed_at = 1325
  portfolio_hidden_at = 2050

  
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
    
    if(scroll < home_message_fixed_at)
      homeImage(scroll ,home_image_original_height , home_image)
    
    home_message = $("#home_message")
    technologies = $(".technologies")
        
    fixableElement(scroll , home_message , technologies , home_message_fixed_at ,1100 , ( -> technologies.addClass('color')) , null , (-> technologies.removeClass('color')) )
    
    portfolio = $("#portfolio")
    works = $(".works")
    fixableElement(scroll , portfolio , works , portfolio_fixed_at ,portfolio_hidden_at)
    
  )
  
  $('a.fancybox').fancybox()

)

homeImage = (scroll , original_height  ,container) ->
    
  #container.height(original_height - scroll / 1.7)
  #container.css('margin-top' , -20 + scroll / 1.1)
  
  container.css('background-position' , 'center ' + ( 40 - scroll / 10) + 'px')
  
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
  

fixableElement = (scroll , current_elem , bottom_elem , fixed_start , fixed_stop , fixed_callback = null , hidden_callback = null , static_callback = null) -> 

  current_hidden = current_elem.data('current_hidden')
  current_fixed = current_elem.data('current_fixed')
  
  console.log("current_hidden : #{current_hidden}" )
  console.log("current_fixed : #{current_fixed}" )
  
  if scroll >= fixed_start  
    
    if !current_fixed
      current_elem.addClass('fixed') 
      new_margin = getMarginTop(current_elem) + getPaddingTop(current_elem) + current_elem.height()
      bottom_elem.css('margin-top', (getMarginTop(bottom_elem) + new_margin) + 'px' )
      
      if fixed_callback != null
        fixed_callback()
        
      current_fixed = true      

    if scroll >= fixed_stop
      current_fixed = false  
      #current_elem.css('top' , 1220 - scroll)
      if(!current_hidden)
        current_elem.stop(true).animate({'top' : -110} , 1000 , -> )
        current_hidden = true
        
        if (hidden_callback != null)
          hidden_callback()
             
    else
      if(current_hidden)
        current_elem.stop(true).animate({ 'top' : 10 } , 1000 , -> )
        current_hidden = false
        
  else 
    if current_fixed
      current_elem.removeClass("fixed")
      bottom_elem.css('margin-top',getMarginTop(current_elem) - current_elem.height())
      
      if static_callback != null
        static_callback()
      
      current_fixed = false  
      
   
  current_elem.data('current_hidden' , current_hidden)
  current_elem.data('current_fixed' , current_fixed)   
      
   

scrollTo = (id) ->
  
  $('html,body').animate(
    {scrollTop: $("##{id}").offset().top} , 3000, 'easeInOutExpo'
  )  
  
scrollToVal = (val) ->
  $('html,body').animate(
    {scrollTop: val} , 3000, 'easeInOutCubic'
  )  

getMarginTop = (elem) ->
  parseInt(elem.css('margin-top').replace('px', ''))
  
getPaddingTop = (elem) ->
  parseInt(elem.css('padding-top').replace('px', ''))
  
  
