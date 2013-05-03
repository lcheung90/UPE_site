class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
    @user = @question.user
    @answer = Answer.new
  end

  def new
    @question = @current_user.questions.build
  end

  def create
    @question = @current_user.questions.build(params[:question])#User.find(params[:user_id]).questions.build(params[:question])
    @question[:view_count] = 0
    if @question.save
      flash[:notice] = "Question successfully added"
      redirect_to user_url(@current_user.username)
    else
      render action: "new"
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
