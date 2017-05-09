class User < ApplicationRecord
  attr_accessor :remember_token

  ### SCOPES

  ### CONSTANTS
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  ### ATTR MACROS
  has_secure_password

  ### ASSOCIATIONS

  ### VALIDATIONS
  validates :email, presence: true,
    length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  validates :name, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  ### CALLBACKS
  before_save {
    self.email = email.downcase
    #email.downcase!
  }

  ### OTHER MACROS
  ### METHODS
  # public methods
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST:
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end
   #returns true if the given token matches the digest
    def authenticated?(remember_token)
      return false if remember_digest.nil?
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
   #forgets a user
    def forget
      update_attribute(:remember_digest, nil)
    end
  # self METHODS
  # remember a user in the database for use in persistent sessions.

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  protected
  # protected methods

  private
  # private methods

end
