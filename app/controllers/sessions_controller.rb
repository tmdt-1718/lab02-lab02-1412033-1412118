class SessionsController < ApplicationController
  def new

  end
  def create
    user = User.find_by(session_params)

    if user.nil?
      session[:error] = "Wrong email or password."
      render :new
    else
      session[:current_user] = user
      session[:success] = "Login successfully."
      redirect_to mail_index_path
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
