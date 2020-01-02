class Question < ActiveRecord::Base
  has_many :answers, dependent: :delete_all
end
