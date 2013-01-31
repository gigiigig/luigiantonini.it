
#load works behavior
window.loadMobile = -> 
  $('.work').click(->
    work_id = $(this).data('work-id')
    window.location.href = "/portfolio?id=#{work_id}&mobile=true"     
  )
  technologies = $('#technologies .technology_image')
  #technologies.removeClass('span2').addClass('span4')
  
  works = $('#works .work')
  works.removeClass('span4').addClass('span6')
  
