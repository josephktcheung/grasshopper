class Conversation < ActiveRecord::Base

  has_many :messages

  validates :created_for, presence: true
  validates :created_by, presence: true
  validate :created_for_and_created_by_cannot_be_same

  def created_for_and_created_by_cannot_be_same
    if created_for == created_by
      errors.add(:created_for, 'cannot be the same as created_by')
    end
  end

end
