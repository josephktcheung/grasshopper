collection @user, root: "users", :object_root => false

attributes :email, :first_name, :last_name, :role, :is_active

node :links do |user|
  {
    apprenticeships: Apprenticeship.involve_user(user).map {|apprenticeship| apprenticeship.id },
    proficiencies: user.proficiencies.map {|proficiency| proficiency.id },
    converstaions: Conversation.involve_user(user).map {|conversation| conversation.id }
  }
end
