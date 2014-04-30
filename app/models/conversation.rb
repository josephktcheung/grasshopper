class Conversation < ActiveRecord::Base

  has_many :messages, inverse_of: :conversation
  belongs_to :created_for, class_name: "User", foreign_key: "created_for_id"
  belongs_to :created_by, class_name: "User", foreign_key: "created_by_id"

  accepts_nested_attributes_for :messages

  scope :involve_user, lambda {|user| where(["created_for_id = ? or created_by_id = ?", user.id, user.id])}

  validates :created_for, presence: true
  validates :created_by, presence: true
  validate :created_for_and_created_by_cannot_be_same
  validate :cannot_have_existing_conversation, on: :create

  def created_for_and_created_by_cannot_be_same
    if created_for == created_by
      errors.add(:created_for, 'sender and recipient cannot be the same')
    end
  end

  def cannot_have_existing_conversation
    initiator = created_by
    recipient = created_for
    if Conversation.find_by(created_by: initiator, created_for: recipient) || Conversation.find_by(created_by: recipient, created_for: initiator)
      errors.add(:created_for, 'conversation with this user already exists')
    end
  end
end
