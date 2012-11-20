# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.loadHome = ->
  
  #set hash for home  
  window.hash('/home')

  #reset styles addeds from jmpress
  window.resetBody()
    
  #load home message function
  home_message = $("#home_message")
  technologies = $("#technologies")
     
  #load portfolio title function
  portfolio = $("#portfolio")
  works = $("#works")    
  
  #elements scroll values
  home_message_fixed_at = home_message.offset().top
  home_message_hidden_at = technologies.offset().top + technologies.height() 
  portfolio_fixed_at = portfolio.offset().top
  portfolio_hidden_at = works.offset().top + works.height()
   
  #start top bar animation
  topBar(0)
 
  home_image = $('#home_image')
  home_image_original_height = home_image.height()

  $(document).scroll((event) ->
    
    #if html and body are animated , prevent default scroll
    #to avoid stuttering
    
    #start top bar animation
    topBar(scroll())
    
    #home image 
    #if(scroll() < home_message_fixed_at)
    homeImage(scroll() ,home_image_original_height , home_image)
    
    fixableElement(scroll() , home_message , technologies , 
      ( -> 
        technologies.addClass('color')
        window.isotopeReorder('#technologies' , '*')), 
      null , (-> technologies.removeClass('color')))
       
    fixableElement(scroll() , portfolio , works , -> window.isotopeReorder('#works' , '*'))
   
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

fixableElement = (scroll , current_elem , bottom_elem , fixed_callback = null , hidden_callback = null , static_callback = null) -> 

  current_elem_name = current_elem.attr('id')
  current_hidden = current_elem.data('current_hidden')
  current_fixed = current_elem.data('current_fixed')

  #calculate start and stop
  if(!current_hidden && !current_fixed)  
    fixed_start = fixedElemStartAt current_elem
    fixed_stop = fixedElemStopAt bottom_elem
    # remove 100 for hide element during current element scroll and not after 
    current_elem.data('fixed_start',fixed_start)
    current_elem.data('fixed_stop',fixed_stop)
  else
    fixed_start = current_elem.data('fixed_start')
    fixed_stop = current_elem.data('fixed_stop') 
    
  #console.log("current_elem : #{current_elem_name}" )
  #console.log("current_hidden : #{current_hidden}" )
  #console.log("current_fixed : #{current_fixed}" )
  #console.log("" )
  
  if scroll >= fixed_start && scroll <= fixed_stop  
    
    if !current_fixed && !current_hidden 
      current_elem.addClass('fixed') 
      new_margin = getFullHeight(current_elem) 
      
      # save element top value to use when elemen return
      fixedElemHider(current_elem, 'init')
      
      bottom_elem.css('margin-top', (getMarginTop(bottom_elem) + new_margin) + 'px' )
      
      if fixed_callback != null
        fixed_callback()
        
      current_fixed = true      
             
    else
      if(current_hidden)
        fixedElemHider(current_elem , 'show')
        current_hidden = false
        current_fixed = true
  
  else if scroll >= fixed_stop
    current_fixed = false  
    #current_elem.css('top' , 1220 - scroll)
    if(!current_hidden)
      fixedElemHider(current_elem , 'hide')
      current_hidden = true
      
      if (hidden_callback != null)
        hidden_callback()
        
  else 
    if current_fixed || current_hidden
      current_elem.removeClass("fixed")
      current_elem.removeAttr('style')
      bottom_elem.css('margin-top', getMarginTop(bottom_elem) - getFullHeight(current_elem))
      
      if static_callback != null
        static_callback()
      
      current_fixed = false  
      
  current_elem.data('current_hidden' , current_hidden)
  current_elem.data('current_fixed' , current_fixed)   


window.fixedElemStartAt =(elem) -> 
  $(elem).offset().top 

window.fixedElemStopAt =(elem) -> 
  $(elem).offset().top + $(elem).height() - 100 

window.fixedElemHider = (elem , operation) ->
  if(elem != undefined)
    switch operation
      when "init" then elem.data('top' , elem.css('top'))
      when "show" then elem.stop(true).animate({ 'top' : elem.data('top') } , 1000 , -> )
      when "hide" 
        new_top = (getFullHeight(elem) - getIntValue(elem.data('top')))      
        elem.stop(true).animate({'top' : -new_top} , 1000 , -> )


# scrollTo = (id) ->
  # $('html,body').animate(
    # {scrollTop: $("##{id}").offset().top} , 3000, 'easeInOutExpo'
  # )
#   

getIntValue = (property) ->
  if(property != undefined)
    parseInt(property.replace('px' , ''))
  else 0

getMarginTop = (elem) ->
  margin_top = elem.css('margin-top')
  if(margin_top != undefined)
    parseInt(margin_top.replace('px', ''))
  else 
    0
  
getPaddingTop = (elem) ->
  padding_top = elem.css('padding-top')
  if padding_top != undefined
    parseInt(padding_top.replace('px', ''))
  else 
  
window.getFullHeight = (elem) ->
  getMarginTop(elem) + getPaddingTop(elem) + elem.height()
