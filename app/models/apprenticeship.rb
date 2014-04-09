class Apprenticeship < ActiveRecord::Base
  belongs_to :master
  belongs_to :apprentice
end
