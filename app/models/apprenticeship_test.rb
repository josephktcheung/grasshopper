class Apprenticeship < ActiveRecord::Base

  belongs_to :master, class_name: "User"
  belongs_to :apprentice, class_name: "User"
  has_many :ratings

  created_at
  updated_at
  end_date
  master
  apprentice
  rating

end