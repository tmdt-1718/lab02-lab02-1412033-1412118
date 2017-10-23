class FriendController < ApplicationController
  before_action :authenticate
  def index
    @friend = User.find(session[:current_user]["id"]).users
  end

  def new

  end

  def show

  end

  private
  def user_params
    	params.require(:user).permit(:name, :email, :password)
    end
    def request_param
      params.require(:user).permit(:email)
  end
end
