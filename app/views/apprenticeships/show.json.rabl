object @apprenticeship

attributes :id, :end_date

node :start_date do |apprenticeship|
  apprenticeship.created_at
end

child :master => :master do |master|
  extends "users/show"
  node :href do
    user_url(master)
  end
end

child :apprentice => :apprentice do |apprentice|
  extends "users/show"
  node :href do
    user_url(apprentice)
  end
end2