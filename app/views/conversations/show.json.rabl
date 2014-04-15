collection @conversation, root: "conversations", :object_root => false

attributes :id, :created_by, :created_for

node :links do |conversation|
  {
    messages: Message.involve_user(conversation.created_by).map {|message| message.id }
  }
end
