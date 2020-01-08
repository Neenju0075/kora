class AnswersController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    @question.answers.create(post_params.merge({user_id: get_current_user.id}))
    redirect_to @question
  end

  def edit
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
  end

  def update
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])

    if @answer.update(post_params)
      redirect_to @question
    else
      render 'answers/edit'
    end
  end

  def destroy
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
    @answer.destroy
    redirect_to @question
  end

  private
  def post_params
    params.require(:answer).permit(:answer)
  end


end
