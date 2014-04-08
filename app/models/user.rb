class User < ActiveRecord::Base

  PASSWORD_RESET_TIME_LIMIT = 1.day

  attr_accessor :password, :password_confirmation

  after_initialize :set_active
  before_create :set_random_password, unless: :password
  before_save :encrypt_password, if: :password
  before_save :downcase_attributes

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, confirmation: true
  validates :is_active, inclusion: { :in => [true, false] }
  validates :first_name, presence: true
  validates :last_name, presence: true

  def set_active
    self.is_active = true
  end

  def self.nil_expired_reset_codes
    User.where( :reset_expires_at.lt => Time.now.gmtime ).unset(
      :reset_code,
      :reset_expires_at
    )
  end

  def self.find_by_code(code)
    User.nil_expired_reset_codes

    if user = User.find_by(
        :reset_code => code,
        :reset_expires_at.gte => Time.now.gmtime
      )
      user.set_reset_expiration
    end

    user
  end

  def self.authenticate(email, password)
    user = User.find_by email: email
    user if user and user.authenticate(password)
  end

  def authenticate(password)
    self.fish == BCrypt::Engine.hash_secret(password, self.salt)
  end

  def set_reset_code
    self.reset_code = SecureRandom.urlsafe_base64
    set_reset_expiration
  end

  def set_reset_expiration
    self.reset_expires_at = PASSWORD_RESET_TIME_LIMIT.from_now
    self.save
  end

  def reset_password(user_params)
    if user_params[:password].blank?
      self.errors.add :password, "can't be blank"
      return false
    else
      if self.update_attributes( user_params )
        self.unset( :reset_code )
        self.unset( :reset_expires_at )
      end
    end
  end

  protected

  def downcase_attributes
    self.email.downcase!
    binding.pry
  end

  def set_salt
    self.salt = BCrypt::Engine.generate_salt
  end

  def encrypt_password
    self.fish = BCrypt::Engine.hash_secret(password, set_salt)
  end

  def set_random_password
    if self.fish.blank?
      self.fish = BCrypt::Engine.hash_secret(SecureRandom.base64(32), set_salt)
    end
  end
end
