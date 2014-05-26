class MessagesController < ApplicationController
  respond_to :html, :js
  before_filter :require_login
  #require 'mymemory'

  def index
    @new_message = Message.new
    @messages = Message.where("created_at >= ?", Time.now - 1.day)
  end

  def create
    @message = current_user.messages.build(message_params)
    if current_user.english
      @message.translated = Mymemory.translate(@message.content, :from => :en, :to => :es).html_safe
    else
      @message.translated = Mymemory.translate(@message.content, :from => :es, :to => :en).html_safe
    end
 
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