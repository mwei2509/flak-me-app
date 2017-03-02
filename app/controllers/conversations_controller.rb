class ConversationsController < ApplicationController
  before_action :set_convo, only:[:index, :show]

  def index
  end

  def show
    if @user.id == params[:id]
      redirect_to convos_path
    end
    @profile_user = User.find(params[:id].to_i)
    @convo = Conversation.get_convo(@user.id, params[:id].to_i)
  end

  def create
    if @user.id == params[:id]
      redirect_to convos_path
    end
    @convo = Conversation.start_convo(@user.id, params[:id].to_i)
    @convo.replies.create(message: params[:message], user_id: session[:id])
    redirect "/convos/#{params[:id].to_i}"
  end

  private
  def set_convo
    @user=current_user
    @convos = Conversation.where("(user_id_1 = #{current_user.id}) OR (user_id_2 = #{current_user.id})").pluck(:user_id_1,:user_id_2)
  end
end
