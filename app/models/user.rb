class User < ApplicationRecord

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
  validates :password, presence: true, length: { minimum: 6 }

  ### CALLBACKS
  before_save {
    #self.email = email.downcase
    email.downcase!
  }

  ### OTHER MACROS
  ### METHODS

  # self METHODS
  # public methods

  protected
  # protected methods

  private
  # private methods

end
