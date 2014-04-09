class Skill < ActiveRecord::Base
  has_many  :skills_users
  has_many :users, through: :skills_users


  before_validation :downcase_name

  validates :skill_name, uniqueness: { case_sensitive: false }


  def downcase_name
    self.skill_name.downcase!
  end

end