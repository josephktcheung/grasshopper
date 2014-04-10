class Skill < ActiveRecord::Base
  has_many :proficiencies
  has_many :users, through: :proficiencies

  before_validation :downcase_name

  validates :skill_name, presence: true, uniqueness: { case_sensitive: false }


  def downcase_name
    self.skill_name.to_s.downcase!
  end

end
