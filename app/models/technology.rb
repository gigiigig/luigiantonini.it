class Technology < ActiveRecord::Base
  
  #change inheritance type for use type as column
  self.inheritance_column = :inheritance_type
  
  scope :is_language, where("technologies.type = 'Language'")
  scope :is_active, where(:active => true)
   
 
  attr_accessible :description, :name , :type , :delete_image , :image , :active
  attr_accessor :delete_image 

  validates :description , :name , :type , :presence => true
  
  has_attached_file :image , :styles => { :normal => "140x80" } , :default_url => "/assets/missing.png"
  
  before_validation do 
    if (delete_image == 1) then image.clear end
  end

end
