class Proficiency < ActiveRecord::Base
  belongs_to :user
  belongs_to :skill

  validates :proficiency_status, inclusion: { :in => %w[desired has] }

end