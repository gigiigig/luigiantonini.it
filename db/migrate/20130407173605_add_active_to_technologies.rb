class AddActiveToTechnologies < ActiveRecord::Migration
  def change
    add_column :technologies, :active, :boolean
  end
end
