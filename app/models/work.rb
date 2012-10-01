class Work < ActiveRecord::Base
  attr_accessible :date, :description, :name
  validate :date , :description , :name ,  :presence => true
end
