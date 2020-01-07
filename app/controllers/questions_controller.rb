class QuestionsController < ApplicationController

  def index
    @question = get_current_user.questions.order("created_at DESC")
  end

  def new
    @question = get_current_user.questions.build
  end


  def create
    @question = get_current_user.questions.build(post_params)

    if @question.save
      redirect_to @question
    else
      render 'new'
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])

    if @question.update(post_params)
      redirect_to @question
    else
      render 'edit'
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    redirect_to questions_path
  end

  private

  def post_params
    params.require(:question).permit(:question)
  end

end
