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
      Apprenticeship.all.map do |apprenticeship|
        {
          href: apprenticeship_url(apprenticeship),
          id: apprenticeship.id,
          master: apprenticeship.master.id,
          apprentice: apprenticeship.apprentice.id,
          created_at: apprenticeship.created_at,
          end_date: apprenticeship.end_date
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





