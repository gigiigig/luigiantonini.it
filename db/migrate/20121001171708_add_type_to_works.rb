class AddTypeToWorks < ActiveRecord::Migration
  def change
    add_column :works, :type, :string
  end
end
