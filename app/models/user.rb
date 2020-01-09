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

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed

  has_many :reverse_relationships, foreign_key: "followed_id",
           class_name:  "Relationship",
           dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  before_destroy :clear_the_session

  public
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  private
  def clear_the_session
    $current_user = nil
  end
end
