class Rating < ActiveRecord::Base

  belongs_to :rater, class_name: "User", foreign_key: "user_id"
  belongs_to :ratee, class_name: "User", foreign_key: "user_id"
  belongs_to :apprenticeship

  rater
  ratee
  apprenticeship
  rating

end