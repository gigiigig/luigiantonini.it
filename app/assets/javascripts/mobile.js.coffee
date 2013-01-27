
#load works behavior
window.loadMobile = -> 
  $('.work').click(->
    work_id = $(this).data('work-id')
    window.location.href = "/portfolio?id=#{work_id}&mobile=true"     
  )