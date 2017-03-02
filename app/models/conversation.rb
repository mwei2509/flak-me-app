class Conversation < ApplicationRecord
  has_many :replies
  belongs_to :user_1, :foreign_key => "user_id_1", :class_name => "User"
  belongs_to :user_2, :foreign_key => "user_id_2", :class_name => "User"

  def self.sort_users(user_id_1, user_id_2)
    id_array=[]
    id_array << user_id_1
    id_array << user_id_2
    sorted=id_array.sort
    return {user_id_1: sorted[0], user_id_2: sorted[1]}
  end

  def self.get_convo(user_id_1, user_id_2)
    convo_id=Conversation.find_by(sort_users(user_id_1,user_id_2))
    Reply.joins(:user).where(conversation_id: convo_id).pluck(:user_id,"users.username",:message)
  end

  def self.start_convo(user_id_1, user_id_2)
    Conversation.find_or_create_by(sort_users(user_id_1,user_id_2))
  end
end
