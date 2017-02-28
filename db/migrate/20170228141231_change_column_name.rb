class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :groups, :topic, :groupname
  end
end
