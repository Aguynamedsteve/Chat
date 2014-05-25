class MessagesController < ApplicationController
  respond_to :html, :js
  before_filter :require_login

  def index
    #@user = current_user
    @new_message = Message.new
    @messages = current_user.messages.where("created_at >= ?", Time.now - 1.day)
  end

  def create
    @message = current_user.messages.build(message_params)
    authorize @message

    if @message.save
      sync_new @message
    end

    respond_with { @message }
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def require_login
    unless current_user
      redirect_to root_path
    end
  end
end