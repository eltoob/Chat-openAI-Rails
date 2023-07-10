class Message < ApplicationRecord
  belongs_to :chat

  validates :content, presence: true
  validates :from, presence: true
end
