class ChatsController < ApplicationController
  def create
    chat = Chat.create(uuid: SecureRandom.uuid)
    redirect_to show_by_uuid_chat_path(chat.uuid)
  end

  def new
  end

  def show
    @chat = Chat.find_by(uuid: params[:uuid])
    @messages = @chat.messages.order(created_at: :asc)
  end
end
