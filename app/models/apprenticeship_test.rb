class Apprenticeship < ActiveRecord::Base

  belongs_to :master, class_name: "User", foreign_key: "user_id"
  belongs_to :apprentice, class_name: "User", foreign_key: "user_id"
  has_many :ratings

  created_at
  updated_at
  end_date
  master
  apprentice
  rating_id

end