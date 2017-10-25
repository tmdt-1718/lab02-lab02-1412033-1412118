class SignupController < ApplicationController
  def new

  end

  def create
    begin
  		user = User.create!(user_params)
  		
  		redirect_to login_path
  	rescue ActiveRecord::RecordInvalid => e

  		render :new
    end
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
