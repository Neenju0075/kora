class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  validates :question_id, presence: true
  validates :user_id, presence: true
  validates :answer, length: { minimum: 1, message: "Answer shouldn't be empty" }
  default_scope -> { order('created_at DESC') }

end
