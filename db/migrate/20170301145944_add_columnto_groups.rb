class AddColumntoGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :active, :boolean, default: true
  end
end
