class Contact 
  
  include ActiveModel::Validations
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  attr_accessor :name , :last_name , :email
  
  validate :name , :last_name , :email , :presence => true
  validates :email , format: { with: VALID_EMAIL_REGEX }

end
