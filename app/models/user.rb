require 'bcrypt'

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor :password, :password_confirmation

  attr_accessible :email    ,
                  :username ,
                  :password ,
                  :password_confirmation,
                  :events

  field :username     , type: String
  field :email        , type: String

  field :hashed       , type: String
  field :salt         , type: String

  field :code         , type: String
  field :expires_at   , type: DateTime

  has_and_belongs_to_many :events

  validates :username , presence:     true
  validates :email    , presence:     true
  validates :email    , uniqueness:   true
  validates :password , confirmation: true

  before_validation :downcase_email
  before_save       :encrypt_password


  def authenticate(password)
    if self.hashed == BCrypt::Engine.hash_secret(password, self.salt)
      self
    else
      nil
    end
  end


  private

    def encrypt_password
      if password.present?
        self.salt = BCrypt::Engine.generate_salt
        self.hashed = BCrypt::Engine.hash_secret(password, self.salt)
        self.password = nil
      end
    end

    def downcase_email
      self.email.downcase! unless email == nil
    end

end
