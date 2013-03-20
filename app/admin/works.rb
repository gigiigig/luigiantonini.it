ActiveAdmin.register Work  do
# Fenu :label => "All" , :parent => "Works"

  config.clear_sidebar_sections!

  form :html => { :multipart => true } do |f|

    f.inputs do
      f.input :name
      f.input :description
      f.input :link
      f.input :date
      f.input :category , :as => :select , :collection => ["Web" , "Mobile" , "Application"]
      f.input :cover, :as => :file, :hint => if(f.object.cover.exists?) then f.template.image_tag(f.object.cover.url(:thumb)) end
      f.input :delete_cover , :as => :boolean
    end

    f.inputs "Product images" do
      f.has_many :pictures do |p|
        p.input :image, :as => :file , :hint => !p.object.image.exists? ? p.template.content_tag(:span, "No Image Yet") : p.template.image_tag(p.object.image.url(:thumb))
        p.input :_destroy, :as=>:boolean, :required => false, :label => 'Remove image'
      end
    end

    f.buttons

  end

  index :download_links => false do

    column :name

    column "Cover" do |work|
      if(work.cover.exists?) then image_tag work.cover.url(:thumb) end
    end

    column :link
    column :date

    column "Images" do |work|
      work.pictures.size
    end

    default_actions

  end

  show do
    attributes_table do
      row :name
      row :description
      row :link
      row :cover do |work|
        if(work.cover.exists?) then image_tag work.cover.url(:thumb) end
      end
      row :pictures do |work|
        work.pictures.each do |picture|
          div do
            image_tag picture.image.url(:thumb)
          end
        end
      end
    end
  end
end

# ActiveAdmin.register_page "Works Categories" do
# menu :label => "Categories" , :parent => "Works"
#
# content do
# end
#
# end
#

