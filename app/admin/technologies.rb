ActiveAdmin.register Technology do

# f.input :author,  :as => :select,      :collection => ["Justin", "Kate", "Amelia", "Gus", "Meg"]
  
  filter :name
  filter :description
  filter :type
  
  # Create sections on the index screen
  scope :all, :default => true
  scope :is_language
  scope :is_active

  form do |f|

    f.inputs  do
      f.input :name
      f.input :description
      f.input :type , :as => :select , :collection => ["Language" , "Framework" , "Platform"]
      f.input :active 
      f.input :image , :as => :file , :hint => (f.template.image_tag(f.object.image.url) if f.object.image.exists?)
      f.input :delete_image, :as=>:boolean, :required => false
    end

    f.buttons

  end

  index :as => :grid  , :download_links => false do |t|

    div :style => "height: 150px" do
      link_to admin_technology_path(t) do
        content_tag(:h3 , t.name) +
        image_tag(t.image.url(:normal))  
      end 
    end
    div do 
        link_to(t(:edit), edit_admin_technology_path(t))
    end

  end

  show do
    attributes_table do
      row :name
      row :description
      row :type
      row :image do |work|
        if(work.image.exists?) then image_tag work.image.url(:normal) end
      end
    end
  end

end
