class Proficiency < ActiveRecord::Base
  belongs_to :user
  belongs_to :skill

  validates :proficiency_status, presence: true, inclusion: { :in => %w[desired has] }

end