class Message < ActiveRecord::Base

  belongs_to :conversation, touch: true
  belongs_to :recipient, class_name: "User"
  belongs_to :sender, class_name: "User"

  validates :recipient, presence: true
  validates :sender, presence: true
  validates :conversation, presence: true
  validates :content, presence: true
  validate :message_to_self?

  def message_to_self?
    if self.recipient == self.sender
      errors.add(:sender, "can't send messages to yourself")
    end
  end

end
