class Skill < ActiveRecord::Base
  has_many  :proficiencys
  has_many :users, through: :proficiencys

  before_validation :downcase_name

  validates :skill_name, uniqueness: { case_sensitive: false }


  def downcase_name
    self.skill_name.downcase!
  end

end
