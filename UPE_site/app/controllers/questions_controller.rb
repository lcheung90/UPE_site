class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
    @question.increment!(:view_count)
    @user = @question.user
    @answer = Answer.new
    @tags = @question.tags.order(:id)
    @tag = @question.tags.build
    @taggings = Tagging.where(:tag_id => @tags.collect{|x| x.id},:question_id => params[:id]).order(:tag_id)
  end

  def new
    @question = @current_user.questions.build
  end

  def create
    @question = @current_user.questions.build(params[:question])#User.find(params[:user_id]).questions.build(params[:question])
    @question[:view_count] = 0
    @question[:score] = 0
    if @question.save
      flash[:notice] = "Question successfully added"
      redirect_to user_url(@current_user.username)
    else
      render action: "new"
    end
  end

  def edit
    @question = @current_user.questions.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(params[:question])
      flash[:notice] = "Question sucessfully updated"
      redirect_to questions_url(params[:id])
    else
      render action: "edit"
    end
  end

  def destroy
    @question = @current_user.questions.find(params[:id])
    if @question.destroy
      flash[:notice] = "Question sucessfully deleted"
      redirect_to user_url(@current_user.username)
    else
      render action: "show"
    end
  end
end
