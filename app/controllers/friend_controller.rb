class FriendController < ApplicationController
  before_action :authenticate
  def index
    @friend = User.find(session[:current_user]["id"]).users
  end

  def new

  end

  def show

  end
  def listrequest
    @cofirm = Confirm.where("user_2_id = ?", session[:current_user]["id"])
    @user = User.find(cofirm.user_id)
  end

  def getrequest
    begin
      @user = User.find_by(email: request_param[:email])
      if(@user.present?)
        @valid = Confirm.find_by(receiver: @user.id, user_id: session[:current_user_id])
        if (@valid.present?)
          logger.debug "Da co trong danh sach yeu cau"
          flash[:error] = "Da co trong danh sach yeu cau"
        else
          @u = @user.users.find_by(id: session[:current_user_id])

           if(@u.present?)
               flash[:error] = "Da co trong danh sach ban be"

           else

             relate = Confirm.create!(receiver: @user.id, user_id: session[:current_user_id])
             flash[:success] = "Send request successfully."
           end
        end
      else
        flash[:error] = "Khong co nguoi nay"
    end
  rescue ActiveRecord::RecordInvalid => e
    flash[:error] = "Cannot register new account."
  end
  redirect_to request.referrer
end

  private
  def user_params
    	params.require(:user).permit(:name, :email, :password)
    end
  def request_param
      params.require(:user).permit(:email)
  end
end
