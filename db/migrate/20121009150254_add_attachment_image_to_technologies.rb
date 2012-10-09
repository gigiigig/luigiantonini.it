class AddAttachmentImageToTechnologies < ActiveRecord::Migration
  def self.up
    change_table :technologies do |t|
      t.has_attached_file :image
    end
  end

  def self.down
    drop_attached_file :technologies, :image
  end
end
