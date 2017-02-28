class CreateRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :roles do |t|
      t.string :role_type
      t.integer :group_id
      t.integer :user_id

      t.timestamps
    end
  end
end
