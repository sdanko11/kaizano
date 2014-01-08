class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_parmas)
    if @message.save
      MessageMailer.contact_us(@message)
      redirect_to root_url, notice: "Message sent! Thank you for contacting us."
    else
      render "new"
    end
  end


  def message_parmas
    params.require(:message).permit(:email, :subject, :message)
  end
end