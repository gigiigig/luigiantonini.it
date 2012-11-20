
#load navigation scripts
#contains both menu items behaviors 
#and scorll navigation

window.loadNavigation = ->
  
  #load porfolio link on menu
  $('a.portfolio').click((event) ->
    event.preventDefault()
    go_to_portfolio()       
  )
    
  $('a.home').click( (e) ->
    e.preventDefault() 
    go_to_home()
  )
  
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

  #show loader
  $('.loader').fadeIn('slow')

  index_container = $('#index_container')
  index_container.css('position' , 'relative')
  
  fixedElemHider($('.fixed'),'hide')
  
  home_image = $('#home_image')
  home_image.css('background-position-y' , '-400px')
  
  if Modernizr.csstransitions
    index_container.css('margin-left' , -$(window).width())
    setTimeout(( -> afterSlide()) ,2000)
  else
    index_container.animate({
        marginLeft: -$(window).width()
      },2000, -> afterSlide())
  
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
  $('#portfolio_container').remove()
  index_container = $('#index_container')
  home_image = $('#home_image')
  home_image.css('background-position-y' , '40px')

  if Modernizr.csstransitions
    index_container.css('margin-left' , 'auto')
    setTimeout(( -> afterSlide()) , 2000)
  else
    index_container.animate({
      marginLeft: 61
    },2000, -> afterSlide())
    
  afterSlide = -> window.resetBody()

#namage scrolling steps
scrollNavigation = ->
  $(document).scroll((event) ->

    greatherThen =  (elem) ->
      value = fixedElemStopAt(elem) - $(window).height() + 100
    
    console.debug "window height : " + $(window).height()
    console.debug "stop at : " + (fixedElemStopAt('#technologies'))
    console.debug "scroll at : " + greatherThen('#technologies')
     
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
  
scrollToVal = (val , callback) ->
  $('html,body').animate(
    {scrollTop: val} , 2000, 'easeInOutCubic' , -> if(callback) then callback() 
  )  
  
scrollToElem = (elem , callback) ->
  console.log "scroll to : #{elem} at : " + $(elem).scrollTop()
  scrollToVal(elemPosition(elem) + 20 , callback)


