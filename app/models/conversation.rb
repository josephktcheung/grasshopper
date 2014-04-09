class Conversation < ActiveRecord::Base

  has_many :messages

  validates :created_for, presence: true
  validates :created_by, presence: true
  validate :created_for_and_created_by_cannot_be_same
  validate :cannot_have_exisitng_conversation

  def created_for_and_created_by_cannot_be_same
    if created_for == created_by
      errors.add(:created_for, 'cannot be the same as created_by')
    end
  end

  def cannot_have_exisitng_conversation
    initiator = created_by
    recipient = created_for
    if Conversation.find_by(created_by: initiator, created_for: recipient) || Conversation.find_by(created_by: recipient, created_for: initiator)
      errors.add(:created_for, 'conversation with this user already exists')
    end
  end

end
