collection @conversation, root: "conversations", :object_root => false

attributes :id

node :links do |conversation|
  {
    created_by:
      {
        href: user_url(conversation.created_by),
        id: conversation.created_by.id,
        type: "user"
      },

    created_for:
      {
        href: user_url(conversation.created_for),
        id: conversation.created_for.id,
        type: "user"
      },

    messages:
      conversation.messages.map do |message|
        {
          href: message_url(message),
          id: message.id,
          type: "messages"
        }
      end
  }
end
