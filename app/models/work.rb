class Work < ActiveRecord::Base
  
  attr_accessible :date, :description, :name, :category
  validate :date , :description , :name ,  :presence => true

end
