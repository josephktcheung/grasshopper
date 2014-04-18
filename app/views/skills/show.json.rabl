collection @skill, root: "skills", :object_root => false

attributes :id, :skill_name

node :links do |skill|
  {
    proficiencies: skill.proficiencies.map do |proficiency|
      {
        href: proficiency_url(proficiency),
        id: proficiency.id,
        type: "proficiencies"
      }
    end
  }
end