ActiveAdmin.register Work  do
# Fenu :label => "All" , :parent => "Works"

  filter :name
  filter :description
  filter :date

  form :html => { :enctype => "multipart/form-data" } do |f|

    f.inputs do
      f.input :name
      f.input :description
      f.input :date
      f.input :cover, :as => :file, :hint => if(f.object.cover.exists?) then f.template.image_tag(f.object.cover.url(:thumb)) end
      f.input :delete_cover , :as => :boolean
    end
    

    f.buttons
  end

  index do

    column :name
    column :description
    column :date

    column "Cover" do |work|
      image_tag work.cover.url(:thumb)
    end

    default_actions
    
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

