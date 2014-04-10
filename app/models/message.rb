class Message < ActiveRecord::Base

  belongs_to :conversation, touch: true
  belongs_to :to_user, class_name: "User"
  belongs_to :from_user, class_name: "User"

  validates :to_user, presence: true
  validates :from_user, presence: true
  validates :conversation, presence: true
  validates :content, presence: true
  validate :message_to_self?

  def message_to_self?
    if self.to_user == self.from_user
      errors.add(:from_user, "can't send messages to yourself")
    end
  end

end
