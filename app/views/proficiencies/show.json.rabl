collection @proficiency, root: "proficiencies", :object_root => false

attributes :id, :proficiency_status

node :links do |proficiency|
  {
    skill:
      {
        href: skill_url(proficiency.skill),
        id: proficiency.skill.id,
        type: "skill"
      },
    user:
      {
        href: user_url(proficiency.user),
        id: proficiency.user.id,
        type: "user"
      }
  }
end