class AddAttachmentCoverToWorks < ActiveRecord::Migration
  def self.up
    change_table :works do |t|
      t.has_attached_file :cover
    end
  end

  def self.down
    drop_attached_file :works, :cover
  end
end
