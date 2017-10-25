class MailController < ApplicationController
 before_action :authenticate

  def new

  end

  def create
    begin
			if(params[:chosen_id].to_s == "")

			else

				@sm = Message.create(body: params[:body])
				Sendmail.create(user_id: session[:current_user]["id"] , message_id: @sm.id)
				Receivemail.create(user_id: params[:chosen_id], message_id: @sm.id, seen: false)

				redirect_to sent_path
			end


		 rescue ActiveRecord::RecordInvalid => e
		
			redirect_to new_mail_path
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
			mes = Message.find(id)

			class << sm
		 		 attr_accessor :body
		 		  attr_accessor :receiver
		 		  attr_accessor :seen
			end

			sm.body = mes.body.from(0).to(30)+"..."
			sm.receiver = mes.receivemail.user.name
			if(mes.receivemail.updated_at.to_datetime == mes.receivemail.created_at.to_datetime )
				sm.seen = "Unread"
			else
				sm.seen = mes.receivemail.updated_at
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
	  	params.require(:message).permit(:chosen_id, :body)
  end
end
