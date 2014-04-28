collection @conversation, root: "conversations", :object_root => false

attributes :id

node :links do |conversation|
  {
    created_by:
      {
        href: user_url(conversation.created_by),
        id: conversation.created_by.id,
        first_name: conversation.created_by.first_name,
        last_name: conversation.created_by.last_name,
        type: "user"
      },

    created_for:
      {
        href: user_url(conversation.created_for),
        id: conversation.created_for.id,
        first_name: conversation.created_for.first_name,
        last_name: conversation.created_for.last_name,
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
