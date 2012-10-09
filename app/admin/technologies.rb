ActiveAdmin.register Technology do

# f.input :author,  :as => :select,      :collection => ["Justin", "Kate", "Amelia", "Gus", "Meg"]
  filter :name
  filter :description
  filter :type

  form do |f|

    f.inputs  do
      f.input :name
      f.input :description
      f.input :type , :as => :select , :collection => ["Language" , "Framework" , "Platform"]
      f.input :image , :as => :file , :hint => (f.template.image_tag(f.object.image.url) if f.object.image.exists?)
      f.input :delete_image, :as=>:boolean, :required => false
    end

    f.buttons

  end

  index :as => :grid do |t|

    html = div do
      link_to(h3 t.name , admin_technology_path(t))
      span image_tag(t.image.url ,  :style => "height: 100px")
    end

    link_to(html, admin_technology_path(t))
    
  end

end
