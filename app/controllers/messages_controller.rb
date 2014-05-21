class MessagesController < ApplicationController

  enable_sync only: [:create, :update, :destroy]

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
      sync_new @message
      redirect_to messages_path
    else
      render "new"
    end
  end
end
