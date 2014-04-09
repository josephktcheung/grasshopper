class Conversation < ActiveRecord::Base

  has_many :messages

  validates :created_for, presence: true
  validates :created_by, presence: true

end
