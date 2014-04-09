class Conversation < ActiveRecord::Base
  validates :created_for, presence: true
  validates :created_by, presence: true
end
