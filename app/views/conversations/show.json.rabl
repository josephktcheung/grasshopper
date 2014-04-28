collection @conversation, root: "conversations", :object_root => false

attributes :id, :updated_at

node :links do |conversation|
  {
    created_by:
      {
        href: user_url(conversation.created_by),
        id: conversation.created_by.id,
        first_name: conversation.created_by.first_name,
        last_name: conversation.created_by.last_name,
        avatar_url: conversation.created_by.avatar.url(:square),
        type: "user"
      },

    created_for:
      {
        href: user_url(conversation.created_for),
        id: conversation.created_for.id,
        first_name: conversation.created_for.first_name,
        last_name: conversation.created_for.last_name,
        avatar_url: conversation.created_for.avatar.url(:square),
        type: "user"
      },

    messages:
      conversation.messages.map do |message|
        {
          href: message_url(message),
          id: message.id,
          content: message.content,
          type: "messages"
        }
      end
  }
end
