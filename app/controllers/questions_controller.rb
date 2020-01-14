class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @question = get_current_user.questions
  end

  def new
    @question = get_current_user.questions.build
  end


  def create
    @question = get_current_user.questions.build(post_params)
    if @question.save
      SendEmailWorker.perform_async(@question.id,get_current_user.id)
      flash[:notice]  = 'Question created!!!'
      redirect_to @question
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @question.update(post_params)
      flash[:notice]  = 'Question Updated!!'
      redirect_to @question
    else
      render 'edit'
    end
  end

  def destroy
    @question.destroy
    flash[:notice]  = 'Question successfully deleted!!!'
    redirect_to questions_path
  end

  private
  def set_question
    @question = Question.find(update_params[:id])
  end

  def post_params
    params.require(:question).permit(:question,:id)
  end

  def update_params
    params.permit(:question,:id)
  end

end
