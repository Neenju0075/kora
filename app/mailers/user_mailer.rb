class UserMailer < ApplicationMailer
  default from: "h.niranjanan@gmail.com"

  def welcome_email(user)
    @user = user
    @url  = "http://localhost:3000/login"
    mail(to: @user.email, subject: 'Welcome to first ruby site')
  end

  def new_question_email(email,question,user)
    @user = user
    @url  = "http://localhost:3000/questions/"+ question.id.to_s
    @qn = question.question.to_s
    mail(to: email, subject: "#{@user.name} posted a new question")
  end
end
