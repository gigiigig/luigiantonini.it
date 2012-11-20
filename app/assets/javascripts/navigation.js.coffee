
#load navigation scripts
#contains both menu items behaviors 
#and scorll navigation

window.loadNavigation = ->
  
  #load porfolio link on menu
  $('a.portfolio').click((event) ->
    event.preventDefault()
    go_to_portfolio()       
  )
    
  $('a.home , .brand').click( (e) ->
    e.preventDefault() 
    go_to_home()
  )
  
     
  $('a.curriculum').fancybox({
      fitToView: true
      height: $(window).height() - 100
      minWidth: $(window).width() / 2 
    })
  
  #load works behavior
  $('.work').click(->
    work_id = $(this).data('work-id')
    #window.location.hash = work_id
    go_to_portfolio("#" + work_id)
        
  )
  
  #load scroll naviagtion
  scrollNavigation()
  
  
#manage loading of portfolio from home page
go_to_portfolio = (start = null) ->

  scroll_time = if scroll() <= 0 then 0 else 2000
  
  scrollToVal(0 , (->
    #show loader
    $('.loader').fadeIn('slow')
  
    index_container = $('#index_container')
    #index_container.css('position' , 'relative')
    
    fixedElemHider($('.fixed'),'hide')
    
    home_image = $('#home_image')
    home_image.css('background-position-y' , '-400px')
      
    setTimeout ->
      if Modernizr.csstransitions
        index_container.css('margin-left' , -$(window).width())
        setTimeout(( -> afterSlide()) ,2000)
      else
        index_container.animate({
            marginLeft: -$(window).width()
          },2000, -> afterSlide())
    ,500)
  , scroll_time)
  
  afterSlide = -> 
    $('html,body').scrollTop(0)
    $.get('portfolio' , (data) ->
      $('#container').append(data)
      $('.loader').hide()
      window.portfolio(start)
    ) 

go_to_home = -> 
  # $.get('/?layout=false' , (data) ->
  #    
  #  
  # )
  portfolio_container = $('#portfolio_container')
  portfolio_container.fadeOut(1000 , -> portfolio_container.remove())
  
  index_container = $('#index_container')
  home_image = $('#home_image')
  
  if Modernizr.csstransitions
    index_container.css('margin-left' , 'auto')
    setTimeout(( -> afterSlide()) , 1000)
  else
    index_container.animate({
      marginLeft: 61
    },1000, -> afterSlide())
    
  afterSlide = -> 
    home_image.css('background-position-y' , '30px')
    window.resetBody()

#namage scrolling steps
scrollNavigation = ->
  $(document).scroll((event) ->

    greatherThen =  (elem) ->
      wh = $(window).height()
      eh = window.getFullHeight($(elem))
      scroll_margin = 100
      to_subtract = (if (eh > wh) then wh else eh - (wh - eh + scroll_margin)) - scroll_margin
      
      value = fixedElemStopAt(elem) - to_subtract
      
      console.debug "stop at : " + fixedElemStopAt(elem)
      console.debug "wh : " + wh
      console.debug "eh : " + eh
      console.debug "value : " + value
      
      value
     
    if !$('body').is(':animated') && !$('html').is(':animated')
      if(scrollDir())
        # control if scroll() > 0 is needed on macos safari becouse of smoth effect 
        if(scroll() > 0 && scroll() < fixedElemStartAt('#home_message') - 100 )
          scrollToElem('#home_message')  
        else if(scroll() > greatherThen('#technologies') && scroll() < fixedElemStartAt('#portfolio') - 100)
          scrollToElem('#portfolio')
  )

#wrappers
fixedElemStopAt = (elem) -> window.fixedElemStopAt(elem)
fixedElemStartAt = (elem) -> window.fixedElemStartAt(elem)
fixedElemHider = (elem , operation) -> window.fixedElemHider(elem,operation)
scroll = -> window.scroll()
scrollDir = -> window.scrollDir()

elemPosition = (elem) ->
  $(elem).offset().top
  
scrollToVal = (val , callback , time = 2000) ->
  $('html,body').animate(
    {scrollTop: val} , time, 'easeInOutCubic' , -> if(callback) then callback() 
  )  
  
scrollToElem = (elem , callback) ->
  scrollToVal(elemPosition(elem) + 20 , callback)


