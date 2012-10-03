ActiveAdmin.register Technology do
  
    # f.input :author,  :as => :select,      :collection => ["Justin", "Kate", "Amelia", "Gus", "Meg"]

    form do |f|
      
      f.inputs  do
        f.input :name
        f.input :description
        f.input :type , :as => :select , :collection => ["Language" , "Framework" , "Platform"] 
      end
      
      f.buttons
     
    end
  
end
