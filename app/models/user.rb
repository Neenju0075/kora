class User < ActiveRecord::Base
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 50 },
                                    uniqueness: { scope: :name, message: "Username already taken " }
  validates :email, presence: true,
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { scope: :email, case_sensitive: false,
                                 message: "Email already taken " }
  validates :password, length: { minimum: 6, message: "password should be atleast 6 character in length" }
  has_many :answers, dependent: :delete_all
  has_many :questions, dependent: :delete_all
end
