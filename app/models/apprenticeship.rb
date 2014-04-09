class Apprenticeship < ActiveRecord::Base

  belongs_to :master, class_name: "User"
  belongs_to :apprentice, class_name: "User"
  has_many :ratings

end
