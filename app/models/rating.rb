class Rating < ActiveRecord::Base
  belongs_to :rater
  belongs_to :ratee
  belongs_to :apprenticeship
end
