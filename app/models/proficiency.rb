class Proficiency < ActiveRecord::Base
  belongs_to :user
  belongs_to :skill

  validates :proficiency_status, presence: true, inclusion: { :in => %w[desired has] }
  validates :user_id, presence: true
  validates :skill_id, presence: true

end