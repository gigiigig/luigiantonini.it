
window.loadIsotope = ->
    
  #load isotope     
  technologies_isotope()
  works_isotope()
  
  $(window).resize( ->
   technologies_isotope()
   works_isotope()  
  ) 
        
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
     
  #for index in [0..elems_to_show - 1]
  # console.debug(index)
  # $('.technology').eq(index).addClass('random')
    
  filters = '#technologies_all': '*' , '#technologies_language' : '.language' , '#technologies_framework' : '.framework' 
  isotopize('#technologies' , filters , '*')
    
isotopize = (container , filters , start_filter) ->
  for elem , filter of filters
    isotopeLink(container ,elem , filter) 
  container = $(container)  
  if container.width() != container.data('width')
    container.data('width', container.width())     
    isotopeReorder(container)

isotopeLink = (container, link ,filter = '*') ->
  $(link).click( -> 
    isotopeReorder(container, filter)    
    return false
  )

window.isotopeReorder = (container, filter) -> 
  sort = $(container).data('isotope-sort')
  if(sort == undefined) then sort = true
  $(container).data('isotope-sort', !sort)
  
  sort_by = if sort then 'original-order' else 'random'
  
  $(container).isotope({
    layoutMode : 'fitRows',
    sortBy : sort_by, 
    sortAscending : sort,
    filter: filter
  })

