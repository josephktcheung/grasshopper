class AddConversationRefToMessages < ActiveRecord::Migration
  def change
    add_reference :messages, :conversation, index: true
  end
end
