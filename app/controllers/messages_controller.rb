class MessagesController < ApplicationController
  def index
    @message = Message.new
    @messages = Message.all
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.create(params.require(:message).permit(:content))

    if @message.save
      redirect_to messages_path
    else
      render "new"
    end
  end
end
