class Technology < ActiveRecord::Base
  
  #change inheritance type for use type as column
  self.inheritance_column = :inheritance_type
  attr_accessible :description, :name , :type , :delete_image
  attr_accessor :delete_image
  
  validates :description , :name , :presence => true
  
  has_attached_file :image , :styles => { :normal => "140x140" } , :default_url => "/assets/missing.png"
  
  before_validation do 
    if (delete_image == 1) then image.clear end
  end

end
