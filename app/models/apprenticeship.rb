class Apprenticeship < ActiveRecord::Base

  belongs_to :master, class_name: "User", foreign_key: "master_id"
  belongs_to :apprentice, class_name: "User", foreign_key: "apprentice_id"
  has_many :ratings

  scope :involve_user, lambda {|user| where(["master_id = ? or apprentice_id = ?", user.id, user.id])}

  after_initialize :set_to_pending

  validate :duplicate_relationship?, on: :create
  validate :same_roles?
  validate :end_before_start?
  validate :master_is_master?
  validate :apprentice_is_apprentice?

  validates :status, presence: true, inclusion: { :in => %w[active inactive pending] }

  def set_to_pending
    self.status = "pending" if self.new_record?
  end

  def duplicate_relationship?
    if Apprenticeship.find_by( master: self.master, apprentice: self.apprentice, status: 'active') or Apprenticeship.find_by( master: self.master, apprentice: self.apprentice, status: 'pending')
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

  def master_is_master?
    if self.master.role != "master"
      errors.add(:id, "apprenticeship master role must be master")
    end
  end

  def apprentice_is_apprentice?
    if self.apprentice.role != "apprentice"
      errors.add(:id)
    end
  end

end