collection @user, root: "users", :object_root => false

attributes :email, :first_name, :last_name, :role, :is_active

node :links do |user|
  {
    apprenticeships:
      Apprenticeship.involve_user(user).map do |apprenticeship|
        {
          href: apprenticeship_url(apprenticeship),
          id: apprenticeship.id,
          type: "apprenticeships"
        }
      end,

    proficiencies:
      user.proficiencies.map do |proficiency|
        {
          href: proficiency_url(proficiency),
          id: proficiency.id,
          type: "proficiencies"
        }
      end,
    conversations:
      Conversation.involve_user(user).map do |conversation|
        {
          href: conversation_url(conversation),
          id: conversation.id,
          type: "conversations"
        }
      end
  }
end
