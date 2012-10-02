class AddCategoryToWorks < ActiveRecord::Migration
  def change
    add_column :works, :category, :string
  end
end
