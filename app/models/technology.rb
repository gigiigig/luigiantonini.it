class Technology < ActiveRecord::Base
  self.inheritance_column = :inheritance_type
  attr_accessible :description, :name , :type
  validates :description , :name , :presence => true
end
