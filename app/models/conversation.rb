class Conversation < ActiveRecord::Base
  validates :created_for, presence: true
end
