class RemoveTypeToWorks < ActiveRecord::Migration
  def up
    remove_column :works, :type
  end

  def down
    add_column :works, :type, :string
  end
end
