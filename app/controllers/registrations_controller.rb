class RegistrationsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to login_path
    else
      redirect_to signup_path, flash[:notice] =  user.errors.messages
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :password, :email)
    end
end
