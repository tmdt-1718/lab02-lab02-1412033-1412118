class MailController < ApplicationController
 before_action :authenticate

  def new
    @sendmail = Sendmail.new
  end

  def create
    @sendmail = Sendmail.new(sendmail_params)
    @sendmail.user_id = current_user.id
    if @sendmail.save
      redirect_to "/sendmails/#{@sendmail.id}"
    else
      render :new
    end
  end

  def index

  end

  def receive
    @rms = User.find(session[:current_user]["id"]).receivemail
    @rms.each do |rm|
      id = rm.message_id
      mail = Message.find(id)

      class << rm
        attr_accessor :body
        attr_accessor :sender
      end
      rm.body = mail.body.from(0).to(30)+"..."
      rm.sender = mail.sendmail.user.name
    end
    @rmss = @rms.sort{ |b,a| a.created_at <=> b.created_at }
  end

  def detailreceive
    rm = Receivemail.find(params[:id])
    if rm.seen
      redirect_to receive_path
    else
      rm.seen = true
      rm.save
      @message = Message.find(rm.message_id)
    end
  end

  def sent
		@sms = User.find(session[:current_user]["id"]).sendmail
		@sms.each do |sm|
			id =  sm.message_id
			messsage = Message.find(id)

			class << sm
		 		 attr_accessor :body
		 		  attr_accessor :receiver
		 		  attr_accessor :seen
			end

			sm.body = messsage.body.from(0).to(30)+"..."
			sm.receiver = messsage.receivemail.user.name
			if(messsage.receivemail.updated_at.to_datetime == messsage.receivemail.created_at.to_datetime )
				sm.seen = "Unread"
			else
				sm.seen = messsage.receivemail.updated_at
			end
		end
		@smss = @sms.sort{ |b,a| a.created_at <=> b.created_at }
  end

  def detailsent
    sendmail =  Sendmail.find(params[:id])
    @message = Message.find(sendmail.message_id)

    end
  def show

  end

  private
  def message_params
    params.require(:message).permit(:user_id, :body)
  end
end
