class UsersController < ApplicationController
before_action :set_user, only:[:edit, :show]

  def dashboard
    @user=User.find(current_user.id)
  end

  def show
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
