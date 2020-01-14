class SendEmailWorker
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: false, backtrace: true


  def perform(qn_id,user_id)
    # Do something
    question = Question.find_by(qn_id)
    user = User.find_by(user_id)
    user.followers.each do |u|
      UserMailer.new_question_email(u.email, question, user).deliver_now
    end
  end
end
