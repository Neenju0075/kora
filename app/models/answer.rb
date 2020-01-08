class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  validates :user_id, presence: true
  validates :answer, length: { minimum: 1, message: "Answer shouldn't be empty" }

end
