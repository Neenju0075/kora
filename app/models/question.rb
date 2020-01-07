class Question < ActiveRecord::Base
  has_many :answers, dependent: :delete_all
  belongs_to :user
  validates :user_id, presence: true
end
