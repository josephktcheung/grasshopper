class Rating < ActiveRecord::Base

  belongs_to :rater, class_name: "User"
  belongs_to :ratee, class_name: "User"
  belongs_to :apprenticeship

  rater
  ratee
  apprenticeship
  rating

end