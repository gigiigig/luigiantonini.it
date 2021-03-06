class Picture < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessible :image

  belongs_to :imageable, :polymorphic => true
  has_attached_file :image , :styles => { :normal => "1024x640", :thumb => "150x150>" }

end