object @apprenticeship

attributes :id, :end_date

attributes :created_at => :start_date

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
end