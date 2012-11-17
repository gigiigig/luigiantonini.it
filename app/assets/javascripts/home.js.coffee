# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.load_home = ->
  
  window.hash('/home')
  
  #reset styles addeds from jmpress
  $('body,html').removeAttr('style')
    
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
  
  #load menu elements
  #loadMenu('a.portfolio' , portfolio_fixed_at)
  
  #load isotope links for portfolio
  works_isotope = -> 
    filters = '#portfolio_all': '*' , '#portfolio_web' : '.web' , '#portfolio_mobile' : '.mobile'
    isotopize('#works' , filters , '*')
  
  #load isotope links for works
  technologies_isotope = ->
    #add random class to worhw wich i want to show
    num_rows = if $(window).height() > 800 then 3 else 2   
    elems_to_show = 3 * num_rows
    
    num_rows = ($('.technology').size() / 3)
    console.debug("tehnologies num rows : #{num_rows}")
    min_height = (num_rows * $('.technology').height() + 160) + "px"
    
    console.debug("tehnologies min height : #{min_height}")
    
    $('#technologies').css('min-height' , min_height );
    
    # if($('.technology').size < elems_to_show) 
    # elems_to_show = $('.technology').size
       
    # for index in [0..elems_to_show - 1]
    # console.debug(index)
    # $('.technology').eq(index).addClass('random')
      
    filters = '#technologies_all': '*' , '#technologies_language' : '.language' , '#technologies_framework' : '.framework' 
    isotopize('#technologies' , filters , '*')
      
  #load isotope     
  technologies_isotope()
  works_isotope()
  $(window).resize( ->
   technologies_isotope()
   works_isotope()  
  ) 
          
  home_image = $('#home_image')
  home_image_original_height = home_image.height()
    
  #test to create javascript portfolio
  $('a.portfolio').click((event) ->
    event.preventDefault()
    home_to_portfolio()       
  )
  
  $('.work').click(->
    work_id = $(this).data('work-id')
    window.location.hash = work_id
    home_to_portfolio()    
  )
  
  home_to_portfolio = -> 

    index_container = $('#index_container')
    index_container.css('position' , 'relative')
    fixedElemHider($('.fixed'),'hide')
    $('.loader').fadeIn('slow')

    index_container.animate({
        marginLeft: -$(window).width()
      },2000, ->
        $('html,body').scrollTop()
        $.get('portfolio' , (data) ->
          $('#container').html(data)
          window.portfolio()
        ) 
    )
  
  $(document).scroll( ->
    
   
    #start top bar animation
    topBar(scroll())
    
    #home image 
    #if(scroll() < home_message_fixed_at)
    homeImage(scroll() ,home_image_original_height , home_image)
    
    fixableElement(scroll() , home_message , technologies , ( -> technologies.addClass('color')) , null , (-> technologies.removeClass('color')) ) 
    fixableElement(scroll() , portfolio , works )
    
    #$('.section_title').each(->
    #  elem = $(this)
    #  next = elem.next()
    #  fixableElement(scroll() , elem , next , elem.offset().top , next.offset().top + next.height())
    #)
    
    scrollNavigation()
    
  )
  
  $('a.fancybox').fancybox()

scroll = -> $(window).scrollTop()
    
old_scroll = 0
scrollDir = ->
  to_return = true
  if(scroll() < old_scroll)
    to_return = false
  old_scroll = scroll()
  to_return
  

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

loadMenu = (elem , scroll)->
  loadMenuElem(elem,scroll)
    
loadMenuElem = (elem, scroll_value) ->
  $(elem).click((e) ->
    e.preventDefault() 
    scrollToVal(scroll_value))
  
scrollNavigation = ->

  greatherThen =  (elem) ->
    value = fixedElemStopAt(elem) - $(window).height() + 100
  
  console.debug "window height : " + $(window).height()
  console.debug "stop at : " + (fixedElemStopAt('#technologies'))
  console.debug "scroll at : " + greatherThen('#technologies')
   
  if !$('body').is(':animated') && !$('html').is(':animated')
    if(scrollDir()) #scroll() > 25 &&
      if( scroll() < fixedElemStartAt('#home_message') - 100)
        scrollToElem('#home_message')  
      else if(scroll() > greatherThen('#technologies') && scroll() < fixedElemStartAt('#portfolio') - 100)
        scrollToElem('#portfolio' , -> $('body,html').stop())


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


fixedElemStartAt =(elem) -> 
  $(elem).offset().top 

fixedElemStopAt =(elem) -> 
  $(elem).offset().top + $(elem).height() - 100 

fixedElemHider = (elem , operation) ->
  if(elem != undefined)
    switch operation
      when "init" then elem.data('top' , elem.css('top'))
      when "show" then elem.stop(true).animate({ 'top' : elem.data('top') } , 1000 , -> )
      when "hide" 
        new_top = (getFullHeight(elem) - getIntValue(elem.data('top')))      
        elem.stop(true).animate({'top' : -new_top} , 1000 , -> )

isotopize = (container , filters , start_filter) ->
  for elem , filter of filters
    isotopeLink(container ,elem , filter) 
  container = $(container)  
  if container.width() != container.data('width')
    container.data('width', container.width()) 
    $(container).isotope({
      layoutMode : 'fitRows',
      sortBy : 'random',
      filter: start_filter
    })

isotopeLink = (container, link ,filter = '*') ->
  $(link).click( -> 
    $(container).isotope({
      layoutMode : 'fitRows',
      sortBy : 'random', 
      filter: filter
    })
    return false
  )

# scrollTo = (id) ->
  # $('html,body').animate(
    # {scrollTop: $("##{id}").offset().top} , 3000, 'easeInOutExpo'
  # )
#   
elemPosition = (elem) ->
  $(elem).offset().top
  
scrollToVal = (val , callback) ->
  $('html,body').animate(
    {scrollTop: val} , 1500, 'easeInOutCubic' , -> if(callback) then callback() 
  )  
  
scrollToElem = (elem , callback) ->
  console.log "scroll to : #{elem} at : " + $(elem).scrollTop()
  scrollToVal(elemPosition(elem) + 20 , callback)

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
  
getFullHeight = (elem) ->
  getMarginTop(elem) + getPaddingTop(elem) + elem.height()
