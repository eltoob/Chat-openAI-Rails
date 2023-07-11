class MessagesController < ApplicationController
  def create
    client = OpenAI::Client.new
    chat = Chat.find_by(uuid: params[:message][:chat_uuid])
    if chat.nil?
      chat = Chat.create(uuid: params[:message][:chat_uuid])
    end
    message = Message.create(content: message_params[:content], chat: chat, from: "user")
    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: chat.messages.map { |message| { role: message[:from], content: message[:content] } }, # Required.
        temperature: 0.7,
      },
    )
    content = response.dig("choices", 0, "message", "content")
    @ai_message = Message.create(content: content, chat: chat, from: "assistant")
    respond_to do |format|
      format.html { redirect_to messages_path }
      format.turbo_stream
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
