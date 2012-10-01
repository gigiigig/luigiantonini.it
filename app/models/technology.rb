class Technology < ActiveRecord::Base
  attr_accessible :description, :name , :type
  validates :description , :name , :presence => true
end
