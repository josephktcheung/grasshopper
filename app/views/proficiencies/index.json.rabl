object false

node :links do
  {
    :"proficiencies.user" => {
      href: root_url + "users/{proficiencies.user}",
      type: "user"
    },
    :"proficiencies.skill" => {
      href: root_url + "skill/{proficiencies.skill}",
      type: "skill"
    }
  }
end

child @proficiencies do
  extends "proficiencies/show"
end

node :linked do
  {
    user:
      users.map do |user|
        {
          href: user_url(user),
          id: user.id,
          username: user.username,
        }
      end,
    skill:
      Proficiency.all.map do |proficiency|
        {
          href: proficiency_url(proficiency),
          id: proficiency.id,
          skill: proficiency.skill.id,
          proficiency_status: proficiency.proficiency_status,
        }
      end,
    conversations:
      Conversation.all.map do |conversation|
        {
          href: conversation_url(conversation),
          id: conversation.id,
          created_by: conversation.created_by.id,
          created_for: conversation.created_for.id
        }
      end
  }
end





