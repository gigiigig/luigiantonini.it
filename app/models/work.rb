class Work < ActiveRecord::Base

  has_many :pictures , :as => :imageable

  accepts_nested_attributes_for :pictures , :pictures_attributes
  attr_accessible :date, :description, :name, :category , :cover , :delete_cover , :pictures_attributes , :pictures
  attr_accessor :delete_cover

  validate :date , :description , :name ,  :presence => true

  has_attached_file :cover , :styles => { :normal => "1024x640", :thumb => "150x150>" }
  
  before_validation { cover.clear if delete_cover == '1' }
  

end
