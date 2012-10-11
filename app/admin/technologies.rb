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

  index :as => :grid  , :download_links => false do |t|

    link_to admin_technology_path(t) do
      content_tag(:h3 , t.name) +
      image_tag(t.image.url ,  :style => "height: 100px")
    end

  #link_to(html, admin_technology_path(t))

  end

  show do
    attributes_table do
      row :name
      row :description
      row :type
      row :image do |work|
        if(work.image.exists?) then image_tag work.image.url end
      end
    end
  end

end
