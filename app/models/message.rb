class Message < ActiveRecord::Base
  belongs_to :conversation, touch: true
end
