object @proficiency

attributes :id, :proficiency_status

child :user do |user|
  extends "users/show"
  node :href do
    user_url(user)
  end
end

child :skill do |skill|
  extends "skills/show"
  node :href do
    skill_url(skill)
  end
end