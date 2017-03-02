class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      t.integer :user_id_1
      t.integer :user_id_2

      t.timestamps
    end
  end
end
