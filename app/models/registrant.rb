class Registrant < ActiveRecord::Base

  REGISTRATION_TIME_LIMIT = 1.day

  before_create :downcase_attributes, :set_code
  before_save :set_registration_expiration

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  def self.destroy_expired_registrants
    Registrant.where(
      :registration_expires_at.lt => Time.now.gmtime
    ).destroy_all
  end

  def self.find_by_code(code)
    Registrant.destroy_expired_registrants

    if registrant = Registrant.find_by(
        :registration_code => code,
        :registration_expires_at.gte => Time.now.gmtime
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
