class Question < ActiveRecord::Base
  has_many :answers, dependent: :delete_all
  belongs_to :user
  validates :user_id, presence: true
  validates :question, length: { minimum: 1, message: "question shouldn't be empty" }

end
