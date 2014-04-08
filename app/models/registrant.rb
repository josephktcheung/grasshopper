class Registrant < ActiveRecord::Base

  REGISTRATION_TIME_LIMIT = 1.day

  before_create :downcase_attributes, :set_code
  before_save :set_registration_expiration

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true

  def self.destroy_expired_registrants
    Registrant.where(
      "registration_expires_at < ?", Time.now.gmtime
    ).destroy_all
  end

  def self.find_by_code(code)
    Registrant.destroy_expired_registrants

    if registrant = Registrant.find_by(
      "registration_code = ? AND registration_expires_at > ?", code, Time.now.gmtime
      )
      registrant.save
    end
    registrant
  end

  def set_registration_expiration
    self.registration_expires_at = REGISTRATION_TIME_LIMIT.from_now
  end

  private

  def downcase_attributes
    self.email.downcase!
  end

  def set_code
    self.registration_code = SecureRandom.urlsafe_base64
  end
end
