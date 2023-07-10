class Chat < ApplicationRecord
  has_many :messages, dependent: :destroy
  after_create :create_hello_message

  private

  def create_hello_message
    self.messages.create(from: "assistant", content: "Hi, how can I help you?")
  end
end
