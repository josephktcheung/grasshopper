class Apprenticeship < ActiveRecord::Base

  belongs_to :master, class_name: "User"
  belongs_to :apprentice, class_name: "User"
  has_many :ratings

  validate :duplicate_relationship?, on: :create
  validate :same_roles?
  validate :end_before_start?

  def duplicate_relationship?
    if Apprenticeship.find_by( master: self.master, apprentice: self.apprentice )
      errors.add(:id, "duplicate relationship")
    end
  end

  def same_roles?
    if self.master.role == self.apprentice.role
      errors.add(:id, "same roles")
    end
  end

  def end_before_start?
    unless !self.end_date || !self.created_at
      if self.end_date < self.created_at
        errors.add(:end_date, "end date cannot be before start date")
      end
    end
  end

end