class CreateReplies < ActiveRecord::Migration[5.0]
  def change
    create_table :replies do |t|
      t.text :message
      t.integer :conversation_id
      t.integer :user_id

      t.timestamps
    end
  end
end
