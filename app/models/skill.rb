class Skill < ActiveRecord::Base
  has_many  :proficiencies
  has_many :users, through: :proficiencies

  before_validation :downcase_name

  validates :skill_name, presence: true, uniqueness: { case_sensitive: false }


  def downcase_name
    unless self.skill_name.nil?
      self.skill_name.downcase!
    end
  end

end
