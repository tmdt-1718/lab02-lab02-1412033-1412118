class SessionsController < ApplicationController
  def new

  end
  def create
    user = User.find_by(session_params)

    if user.nil?
    
      render :new
    else
      session[:current_user] = user

      redirect_to receive_path
    end
  end

  def destroy
    session.delete(:current_user)
    redirect_to login_path
  end

  private
  def session_params
    params.require(:session).permit(:email, :password)
  end

end
