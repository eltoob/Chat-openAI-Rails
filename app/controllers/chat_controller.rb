class ChatController < ApplicationController
  def new
  end

  def show
    @messages = Message.all.order(created_at: :asc)
  end
end
