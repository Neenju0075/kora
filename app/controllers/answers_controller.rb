class AnswersController < ApplicationController
  before_action :set_question, only: [:create, :edit, :update, :destroy, :set_answer]
  before_action :set_answer, only: [:destroy,:update,:edit]

  def create
    @question.answers.create(post_params.merge({user_id: get_current_user.id}))
    flash[:notice]  = 'New answer posted!!!'
    redirect_to @question
  end

  def edit
  end

  def update
    if @answer.update(post_params)
      flash[:notice]  = "( #{@answer.answer} ) Updated!!!!!"
      redirect_to @question
    else
      render 'answers/edit'
    end
  end

  def destroy
    @answer.destroy
    flash[:notice]  = "( #{@answer.answer} ) Deleted!!!!"
    redirect_to @question
  end

  private

  def set_question
    @question = Question.find(update_params[:question_id])
  end

  def set_answer
    @answer = @question.answers.find(update_params[:id])
  end

  def post_params
    params.require(:answer).permit(:answer)
  end

  def update_params
    params.permit(:id,:question_id,:answer)
  end


end
