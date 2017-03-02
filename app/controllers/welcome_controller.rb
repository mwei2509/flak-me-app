class WelcomeController < ApplicationController

  skip_before_action :authenticate_user!

  def welcome
    if current_user
      redirect_to dashboard_path
    else
      @user=User.new
      render :welcome
    end
  end
end
