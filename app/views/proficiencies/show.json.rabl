object @proficiency

attributes :id, :proficiency_status

node :links do |proficiency|
  {
    user: {
      id: proficiency.user.id,
      href: user_url(proficiency.user),
      first_name: proficiency.user.first_name,
      last_name: proficiency.user.last_name,
      username: proficiency.user.username,
      role: proficiency.user.role
    }
  }
end