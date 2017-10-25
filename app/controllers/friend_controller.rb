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
    @users = Confirm.where(user_2_id: session[:current_user]["id"])

  end
  ##xoa ban
  def delete
    @delete1 = Friend.find_by(user_1_id: session[:current_user]["id"], user_2_id: params[:id])
    @delete1.destroy
    @delete2 = Friend.find_by(user_2_id: session[:current_user]["id"], user_1_id: params[:id])
    @delete2.destroy
    redirect_to friendlist_path
  end


  def accept

    @req = Confirm.find_by(user_2_id: session[:current_user]["id"], user_1_id: params[:id])
    if (@req.present?)
      num1 = User.find(params[:id])
      num2 = User.find(session[:current_user]["id"])
      num1.users.push(num2)
      num2.users.push(num1)
      @req.destroy
      redirect_to listrequest_path
    else

    end

  end

  def sendrequest
    begin
      @user = User.find_by(email: request_param[:email])
      if(@user.present?)
        if (@user.id == session[:current_user]["id"])
          flash[:error] = "Cannot send request to yourself"
        else
        @valid = Confirm.find_by(user_1_id: session[:current_user]["id"], user_2_id: @user.id)
        if @valid.present?
          flash[:error] = "You have already sent this request."
        else

        @u = Friend.find_by(user_1_id: session[:current_user]["id"], user_2_id: @user.id)

          if(@u.present?)

              flash[:error] = "User has already been added to friend list."

          else
            Confirm.create!(user_1_id: session[:current_user]["id"],user_2_id: @user.id)
            flash[:success] = "Friend request sent."
          end
        end
      end
      else
        flash[:error] = "User does not exist."
      end
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
