collection @message, root: "messages", :object_root => false

attributes :id, :content, :created_at, :updated_at

node :links do |message|
  {
    conversation:
      {
        href: conversation_url(message.conversation),
        id: message.conversation.id,
        type: "conversations"
      },

    sender:
      {
        href: user_url(message.sender),
        id: message.sender.id,
        type: "users"
      },

    recipient:
      {
        href: user_url(message.recipient),
        id: message.recipient.id,
        type: "users"
      }
  }
end