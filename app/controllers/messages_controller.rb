class MessagesController < ApplicationController
  def create
    client = OpenAI::Client.new
    message = Message.create(message_params.merge(chat: Chat.first, from: "user"))
    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: [{ role: "user", content: message.content }], # Required.
        temperature: 0.7,
      },
    )
    content = response.dig("choices", 0, "message", "content")
    @ai_message = Message.create(content: content, chat: Chat.first, from: "assistant")
    respond_to do |format|
      format.html { redirect_to messages_path }
      format.turbo_stream
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
