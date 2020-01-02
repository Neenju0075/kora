class QuestionsController < ApplicationController


  def index
    @question = Question.all.order("created_at DESC")
  end

  def new
    @question = Question.new
  end


  def create
    @question = Question.new(post_params)

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
