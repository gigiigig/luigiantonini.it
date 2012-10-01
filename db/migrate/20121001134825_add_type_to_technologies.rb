class AddTypeToTechnologies < ActiveRecord::Migration
  def change
    add_column :technologies, :type, :string
  end
end
